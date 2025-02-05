BeginPackage["JerryI`WolframJSFrontend`Dev`", {"JerryI`WolframJSFrontend`Colors`"}];

(* 
    ::Only for MASTER kernel::
    
    Autobuilder/configurator package 
*)

LoadBuildFile::usage = "LoadBuildFile[] loads the build configuration"
MergeFiles::usage = "MergeFiles[{from,from,from}->to]"


Begin["`Private`"]; 

JerryI`WolframJSFrontend`Dev`wdates = FileDate/@FileNames["*.js", JerryI`WolframJSFrontend`Dev`config["watch"], Infinity];
JerryI`WolframJSFrontend`Dev`config = Null;

CheckFiles := With[{cf = JerryI`WolframJSFrontend`Dev`config},
    If[JerryI`WolframJSFrontend`Dev`wdates =!= FileDate/@FileNames["*.js", cf["watch"], Infinity], Rebuild];
    JerryI`WolframJSFrontend`Dev`wdates = FileDate/@FileNames["*.js", cf["watch"], Infinity];
];

Rebuild := With[{cf = JerryI`WolframJSFrontend`Dev`config},
    Print[Magenta<>"rebuilding..."]; Print[Reset];
    cf["recipy"];
    Print[Green<>"project was rebuilded"]; Print[Reset];
];

Options[MergeFiles] = {"PostProcess" -> Function[x, x]};

MergeFiles[Rule[files_, target_], OptionsPattern[]] := (
    Export[target, OptionValue["PostProcess"][StringRiffle[Import[#, "String"] &/@ Flatten[files], "\r\n"]], "String"];
    Print[Blue<>"merged to "<>target]; Print[Reset];
);

LoadBuildFile[file_String] := With[{},
    JerryI`WolframJSFrontend`Dev`config = Get[file];
    CheckFiles;
    SessionSubmit[ScheduledTask[CheckFiles, Quantity[3, "Seconds"]]];
];

End[];
EndPackage[];