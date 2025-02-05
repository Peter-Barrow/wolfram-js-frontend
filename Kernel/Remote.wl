
BeginPackage["JerryI`WolframJSFrontend`Remote`", {"JTP`", "KirillBelov`WebSocketHandler`"}]; 

(* 
    ::Only for SECONDARY kernel::

    A remote/local kernel essential package
    used to communicate with a master kernel and evaluation
*)

ConnectToMaster::usage = "Connects to the master-kernel"
SendToMaster::usage = "Send evaluated the data inside the callback to the master kernel"

AttachNotebook::usage = "add the notebook id"
SendToFrontEnd::usage = "send to frontend directly, if the notebook id is known"

FrontSubmit::usage = "alias to SendToFrontEnd"

MetaObject::usage = "Meta object represents objects created using FrontSubmit with MetaMarkers"

ExecutableInstanceObject::usage = "Represents all executables found by MetaMarkers"

MetaMarker::usage = ""

AskMaster::usage = "send expr to master and wait for the result"

MasterResolvePromise::usage = "resolve promise"

WSSocketEstablish::usage = "establish connection"

$ExtendDefinitions::usage = "extend defs"

NotebookAddTracking::usage = "add tracking for a symbol"


Begin["`Private`"]; 



master = Null;
mastersync = Null;
notebook = Null;
path = Null;
oldpath = Null;


Unprotect[NotebookDirectory];
ClearAll[NotebookDirectory];
NotebookDirectory[]


Unprotect[EvaluationNotebook];
ClearAll[EvaluationNotebook];
EvaluationNotebook[args___] := notebook


Options[ConnectToMaster] = {"PingCheck"->False};

AskMaster[expr_] := With[{n = notebook}, JTPClientEvaluate[mastersync, expr[n]] ];

MasterSubmit[expr_] := JTPClientEvaluate[mastersync, expr];

MasterResolvePromise[expr_][uid_] := With[{res = expr//ReleaseHold},
  Print["MasterResolvePromise  with "<>uid];
  JTPClientEvaluateAsyncNoReply[master, Global`LocalKernelPromiseResolve[uid, res]];
]

ConnectToMaster[params_List, OptionsPattern[]] := (

    master = (JTPClient@@params) // JTPClientStart;
    JTPClientStartListening[master];

    mastersync = (JTPClient@@params) // JTPClientStart;

    (* update the status on the master kernel *)
    JTPClientEvaluateAsyncNoReply[master, Global`LocalKernel["Started"]];

    (*SessionSubmit[ScheduledTask[        
        (* JTPClientEvaluateAsyncNoReply[master, Global`LocalKernel["Pong"]] *), Quantity[1, "Seconds"]]]*)
);

notebookClient = Null;

(* might be slow on converting to JSON *)
(* we neeed to use Compress instead *)
SendToFrontEnd[expr_] := With[{e = ExportByteArray[expr, "ExpressionJSON"]},  
  WebSocketSend[notebookClient, e];
];

SendToFrontEnd[expr_, cli_] := With[{e = ExportByteArray[expr, "ExpressionJSON"]},  
  WebSocketSend[cli, e];
];

FrontSubmit[expr_] := With[{e = ExportByteArray[expr, "ExpressionJSON"]},  
  WebSocketSend[notebookClient, e];
];

FrontSubmit[expr_, mark_MetaMarker] := With[{e = ExportByteArray[Global`FrontSubmitAlias[expr, mark], "ExpressionJSON"]},  
  WebSocketSend[notebookClient, e];
];

(* for meta Markers *)
FrontSubmit[expr_, mark_MetaMarker, "Reference"->True] := With[{uid = CreateUUID[]},
With[{e = ExportByteArray[Global`FrontSubmitExtended[expr, mark, uid], "ExpressionJSON"]},  
  WebSocketSend[notebookClient, e];
];
  MetaObject[uid]
];

Delete[MetaObject[uid_]] ^:= With[{e = ExportByteArray[Global`DeleteExecutablesBox[uid], "ExpressionJSON"]},  
  WebSocketSend[notebookClient, e];
];

(* for regular expressions *)
(* automatic containerization? no make it as spearate option *)
FrontSubmit[expr_, "Reference"->True] := With[{uid = CreateUUID[]}, NotImplemented];

(*SetAttributes[FrontSubmit, HoldFirst]*)

WSSocketEstablish := (
  notebookClient = Global`client;
  WebSocketSend[notebookClient, ExportByteArray[Global`FrontEndWSAttached[Null], "ExpressionJSON"]];
  activateSymbolDef;
);

NotebookAddTracking[symbol_] := With[{cli = Global`client, name = SymbolName[Unevaluated[symbol]]},
    
    Experimental`ValueFunction[Unevaluated[symbol]] = Function[{y,x}, 
      If[FailureQ[
        WebSocketSend[cli, ExportByteArray[Global`FrontUpdateSymbol[name, x], "ExpressionJSON"]]
      ],
        Print["tracking of "<>ToString[Unevaluated[symbol]]<>" was removed for "<>cli[[1]]];
        Unset[Experimental`ValueFunction[Unevaluated[symbol]]];
      ]
    ]
]

$DefinedUserSymbols = {};


SetAttributes[NotebookAddTracking, HoldFirst];

SendToMaster[cbk_][args__] := JTPClientEvaluateAsyncNoReply[master, cbk[args]];

$ExtendDefinitions[uid_, defs_] := With[{id = notebook}, 
  JTPClientEvaluateAsyncNoReply[master, Global`NExtendSingleDefinition[uid, defs][id] ] 
];

AttachNotebook[id_, path_] := ( 
  notebook = id; SetDirectory[path]; 
  
  JTPClientEvaluateAsyncNoReply[master, Global`NotebookFrontEndSend[id][Global`FrontEndNotebookAttached[Null]] ];
);

DefineOutputStreamMethod[
  "ToastWarning", {"ConstructorFunction" -> 
    Function[{name, isAppend, caller, opts}, 
     With[{state = Unique["JaBoo"]},
      {True, state}]], 
   "CloseFunction" -> Function[state, ClearAll[state]], 
   "WriteFunction" -> 
    Function[{state, bytes},(*Since we're writing to a cell,
     we don't want that trailing newline.*)
     With[{out = bytes /. {most___, 10} :> FromCharacterCode[{most}]},
       With[{ }, 
       If[out === "", {0, state},
       

        With[{text =ByteArrayToString[out // ByteArray], uid = notebook},
            JTPClientEvaluateAsyncNoReply[master, Global`NotebookEventFire[uid]["Warning"][text] ];
           
        ];

        {Length@bytes, state}]]]]}
];

DefineOutputStreamMethod[
  "ToastPrint", {"ConstructorFunction" -> 
    Function[{name, isAppend, caller, opts}, 
     With[{state = Unique["JaBoo"]},
      {True, state}]], 
   "CloseFunction" -> Function[state, ClearAll[state]], 
   "WriteFunction" -> 
    Function[{state, bytes},(*Since we're writing to a cell,
     we don't want that trailing newline.*)
     With[{out = bytes /. {most___, 10} :> FromCharacterCode[{most}]},
       With[{ }, 
       If[out === "", {0, state},
       

        With[{text =ToString[out], uid = notebook},
            JTPClientEvaluateAsyncNoReply[master, Global`NotebookEventFire[uid]["Print"][text] ];
       
        ];

        {Length@bytes, state}]]]]}
];

$Messages = {OpenWrite[Method -> "ToastWarning"]};
$Output = {OpenWrite[Method -> "ToastPrint"]};

$DefinedUserSymbols = {};
$AccosicatedClients = <||>;

GetDefinedSymbols := With[{cli = Global`client},
   
    $AccosicatedClients[cli] = Function[{name, context}, 
      If[FailureQ[
        WebSocketSend[cli, ExportByteArray[Global`FrontAddDefinition[{{name, context}}], "ExpressionJSON"]]
      ],
        Print["definitions tracker was removed for "<>cli[[1]]];
        Unset[$AccosicatedClients[cli]];
      ]
    ];

    WebSocketSend[cli, ExportByteArray[Global`FrontAddDefinition[$DefinedUserSymbols], "ExpressionJSON"]];
];

ShareSymbolDefinition[{name_, context_}] := $AccosicatedClients[#][name, context] &/@ Keys[$AccosicatedClients];


activateSymbolDef := (
  SessionSubmit[ScheduledTask[
    $NewSymbol = If[#2 === "Global`", (AppendTo[$DefinedUserSymbols, {#1, #2}]; ShareSymbolDefinition[{#1, #2}]; )]&;
    Print["Definitons tracking is activated!"];  
  , {Quantity[5, "Seconds"], 1}]];

  activateSymbolDef = Null;
)

End[];
EndPackage[];