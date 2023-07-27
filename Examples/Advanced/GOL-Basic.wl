<|"notebook" -> <|"name" -> "Expostulation", "id" -> "duel-8e03e", 
   "kernel" -> LocalKernel, "objects" -> <||>, 
   "path" -> "Examples\\Advanced\\GOL-Basic.wl", "cell" :> Exit[], 
   "date" -> DateObject[{2023, 7, 27, 17, 4, 10.0208786`8.753480762697702}, 
     "Instant", "Gregorian", 2.], "symbols" -> <||>, 
   "channel" -> WebSocketChannel[
     KirillBelov`WebSocketHandler`WebSocketChannel`$16]|>, 
 "cells" -> {<|"id" -> "72dc84ab-65f0-49a8-a4fb-d7976721650c9d1", 
    "type" -> "input", "data" -> 
     ".md\n# GOL: Example with a simple call\nUsing frontend function", 
    "display" -> "codemirror", "sign" -> "duel-8e03e", 
    "props" -> <|"hidden" -> True|>|>, 
   <|"id" -> "283ccc36-a669-42ad-b930-f3393d981faa9d1", "type" -> "output", 
    "data" -> "\n# GOL: Example with a simple call\nUsing frontend function", 
    "display" -> "markdown", "sign" -> "duel-8e03e", 
    "props" -> <|"hidden" -> False|>|>, 
   <|"id" -> "d0d15f03-9e9c-4f47-9c0e-e2e3578893b39d1", "type" -> "input", 
    "data" -> ".js\n//create js canvas\nconst canvas = \
document.createElement(\"canvas\");\ncanvas.width = 400;\ncanvas.height = \
400;\n\nlet context = canvas.getContext(\"2d\");\ncontext.fillStyle = \
\"lightgray\";\ncontext.fillRect(0, 0, 500, 500);\n\n//an array to store the \
previous state\nlet old = new Array(40);\nfor (let i = 0; i < old.length; \
i++) {\n  old[i] = new Array(40).fill(0); \n}\n\n//a function to draw on \
it\ncore.MyFunction = async (args, env) => {\n  const data = await \
interpretate(args[0], env);\n\n  //draw our boxes\n  for(let i=0; i<40; ++i) \
{\n    for (let j=0; j<40; ++j) {\n      //old pixels will leave blue \
traces\n      if (old[i][j] > 0) {\n        context.fillStyle = \
\"rgba(0,0,255,0.2)\"; \n        context.fillRect(i*10 + 2, j*10 + 2, 6, \
6);\n      }\n      //new pixels\n      if (data[i][j] > 0) {\n        \
context.fillStyle = \"rgba(255,0,0,0.4)\"; \n        context.fillRect(i*10 + \
1, j*10 + 1, 8, 8);\n      } else {\n        context.fillStyle = \
\"rgba(255,255,255,0.4)\"; \n        context.fillRect(i*10 + 1, j*10 + 1, 8, \
8);\n      }\n      \n      //store the previous frame\n      old[i][j] = \
data[i][j];\n    }\n  }\n}\n\nreturn canvas", "display" -> "codemirror", 
    "sign" -> "duel-8e03e", "props" -> <|"hidden" -> False|>|>, 
   <|"id" -> "4a501f5a-cd9d-4b76-93d2-7aa0f7ee15dc", "type" -> "output", 
    "data" -> "\n//create js canvas\nconst canvas = \
document.createElement(\"canvas\");\ncanvas.width = 400;\ncanvas.height = \
400;\n\nlet context = canvas.getContext(\"2d\");\ncontext.fillStyle = \
\"lightgray\";\ncontext.fillRect(0, 0, 500, 500);\n\n//an array to store the \
previous state\nlet old = new Array(40);\nfor (let i = 0; i < old.length; \
i++) {\n  old[i] = new Array(40).fill(0); \n}\n\n//a function to draw on \
it\ncore.MyFunction = async (args, env) => {\n  const data = await \
interpretate(args[0], env);\n\n  //draw our boxes\n  for(let i=0; i<40; ++i) \
{\n    for (let j=0; j<40; ++j) {\n      //old pixels will leave blue \
traces\n      if (old[i][j] > 0) {\n        context.fillStyle = \
\"rgba(0,0,255,0.2)\"; \n        context.fillRect(i*10 + 2, j*10 + 2, 6, \
6);\n      }\n      //new pixels\n      if (data[i][j] > 0) {\n        \
context.fillStyle = \"rgba(255,0,0,0.4)\"; \n        context.fillRect(i*10 + \
1, j*10 + 1, 8, 8);\n      } else {\n        context.fillStyle = \
\"rgba(255,255,255,0.4)\"; \n        context.fillRect(i*10 + 1, j*10 + 1, 8, \
8);\n      }\n      \n      //store the previous frame\n      old[i][j] = \
data[i][j];\n    }\n  }\n}\n\nreturn canvas", "display" -> "js", 
    "sign" -> "duel-8e03e", "props" -> <|"hidden" -> False|>|>, 
   <|"id" -> "9b2eba36-ab9f-4aeb-8dc1-2ca25f7d6ac79d1", "type" -> "input", 
    "data" -> ".md\nWolfram Mathematica code", "display" -> "codemirror", 
    "sign" -> "duel-8e03e", "props" -> <|"hidden" -> True|>|>, 
   <|"id" -> "27fbf4c5-551a-4616-a4cb-77be4050a03b9d1", "type" -> "output", 
    "data" -> "\nWolfram Mathematica code", "display" -> "markdown", 
    "sign" -> "duel-8e03e", "props" -> <|"hidden" -> False|>|>, 
   <|"id" -> "f491da17-cbe4-40f4-98b4-779f0163a58f9d1", "type" -> "input", 
    "data" -> "gameOfLife = {224, {2, {{2, 2, 2}, {2, 1, 2}, {2, 2, 2}}}, {1, \
1}};\nboard = RandomInteger[1, {40, 40}];\nDo[\n  MyFunction[board = \
CellularAutomaton[gameOfLife, board, {{0, 1}}] // Last] // FrontSubmit;\n  \
Pause[0.1];\n, {i,1,100}]", "display" -> "codemirror", 
    "sign" -> "duel-8e03e", "props" -> <|"hidden" -> False|>|>}, 
 "serializer" -> "jsfn3"|>
