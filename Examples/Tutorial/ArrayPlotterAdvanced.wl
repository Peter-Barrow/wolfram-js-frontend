<|"notebook" -> <|"name" -> "Ashtray", "id" -> "burgundy-e8f61", 
   "kernel" -> LocalKernel, "objects" :> 
    <|"ab47f5bd-0aeb-471b-9411-963c9a792c5d" -> 
      <|"json" -> "[\"ArrayDraw\",[\"List\",[\"List\",0,0,0,0,0,0,0,0,0,0,0,1\
,0,0,0,1,0,0,0,1],[\"List\",0,1,1,1,0,0,0,0,0,1,0,1,1,0,0,1,1,1,0,0],[\"List\
\",1,1,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,1],[\"List\",0,0,0,0,1,1,0,0,0,0,0,1\
,0,0,0,0,0,0,1,0],[\"List\",0,0,0,1,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0],[\"List\
\",0,0,0,0,0,1,1,0,1,0,0,1,1,0,0,1,0,0,0,0],[\"List\",1,0,0,0,0,0,0,0,1,0,0,1\
,1,0,0,1,1,0,0,0],[\"List\",1,1,0,0,0,0,0,0,0,0,0,1,0,1,1,0,0,0,0,0],[\"List\
\",0,0,1,0,0,0,0,0,0,0,0,1,0,1,1,1,1,0,0,0],[\"List\",0,0,0,0,0,0,1,0,0,0,0,1\
,0,0,0,0,0,0,0,0],[\"List\",1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0],[\"List\
\",0,0,0,1,1,1,0,1,0,1,0,1,0,0,1,1,1,1,0,0],[\"List\",0,0,0,0,0,0,0,1,0,0,1,1\
,1,1,1,0,0,0,1,0],[\"List\",0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,1,0,0,0],[\"List\
\",0,0,0,0,1,0,0,1,0,0,0,1,0,0,1,0,1,1,0,0],[\"List\",1,0,1,0,0,0,1,0,0,0,1,0\
,1,0,0,1,0,0,0,0],[\"List\",1,1,0,0,0,0,1,0,0,0,1,0,1,1,1,0,0,1,0,1],[\"List\
\",0,0,1,1,0,0,0,0,1,0,1,1,0,0,0,1,0,1,1,0],[\"List\",1,0,0,0,0,0,1,0,0,0,0,0\
,1,0,0,0,0,0,1,0],[\"List\",0,1,0,0,0,0,0,0,0,0,1,0,1,1,0,1,0,0,1,1]]]", 
       "date" -> DateObject[{2023, 7, 28, 12, 28, 
          20.935524`8.073458819123713}, "Instant", "Gregorian", 2.]|>, 
     "0fbc17cd-4cd3-46ec-878e-0693f6e96684" -> 
      <|"json" -> "[\"ArrayDraw\",[\"Hold\",\"board\"]]", 
       "date" -> DateObject[{2023, 7, 28, 12, 28, 
          26.941498`8.182996721749591}, "Instant", "Gregorian", 2.]|>|>, 
   "path" -> "/Volumes/Data/Github/wolfram-js-frontend/Examples/Tutorial/Arra\
yPlotterAdvanced.wl", "cell" :> Exit[], 
   "date" -> DateObject[{2023, 7, 28, 12, 28, 1.323278`6.874226081134362}, 
     "Instant", "Gregorian", 2.], "symbols" -> 
    <|"board" -> <|"date" -> DateObject[{2023, 7, 28, 12, 28, 
          26.327324`8.172981700228938}, "Instant", "Gregorian", 2.]|>|>, 
   "channel" -> WebSocketChannel[
     KirillBelov`WebSocketHandler`WebSocketChannel`$19]|>, 
 "cells" -> {<|"id" -> "b3279548-7ebe-4b55-ac8c-71faba194098df9", 
    "type" -> "input", "data" -> 
     ".md\nFirstly, we need to hide all variables to the scope of a function"\
, "display" -> "codemirror", "sign" -> "burgundy-e8f61", 
    "props" -> <|"hidden" -> True|>|>, 
   <|"id" -> "07c53f4d-dddf-49d2-a7e5-f9cb0e789268", "type" -> "output", 
    "data" -> 
     "\nFirstly, we need to hide all variables to the scope of a function", 
    "display" -> "markdown", "sign" -> "burgundy-e8f61", 
    "props" -> <|"hidden" -> False|>|>, 
   <|"id" -> "2a05d533-818d-4424-b513-3d392f2b0e12df9", "type" -> "input", 
    "data" -> ".js\n//global function\nwindow.getRandomInt = (max) => {\n  \
return Math.floor(Math.random() * max);\n}\n\ncore.ArrayDraw = async (args, \
env) => {\n  const canvas = document.createElement('canvas');\n  canvas.width \
= 300;\n  canvas.height = 300;\n  \n  //append our canvas to the provided \
DOM\n  env.element.appendChild(canvas);\n  \n  let context = \
canvas.getContext(\"2d\");\n  \n  //use local memory to store the canvas\n  \
env.local.ctx = context;\n\n  //store the data in JS\n  const innerData = \
[];\n  env.local.innerData = innerData;\n\n  const array = await \
interpretate(args[0], env);\n  \n  const width = array.length ;\n  const \
height = array[0].length;\n  \n  array.forEach((row, i) => {\n    \
row.forEach((cell, j) => {\n      if (cell < 1) return;\n\n      //add new \
data to the local store\n      innerData.push({\n        coordinates: \
[Math.floor(i * (300/width))-1, Math.floor(j * (300/height))-1, \
Math.floor((300/width)-1), Math.floor((300/height)-1)],\n        lifetime: \
1,\n      });\n\n      //limit the number of points\n      if \
(innerData.length > 30*30) innerData.shift();\n    });\n  });\n\n  \
//animation function\n  function animate() {\n    context.fillStyle = \
\"white\";\n    context.fillRect(0, 0, 300, 300);\n\n    //draw all data from \
the store and fade it based on the lifetime\n    for (let i=0; \
i<innerData.length; ++i) {\n      context.fillStyle = \
`rgba(${255/innerData[i].lifetime},0,${255 - 255/innerData[i].lifetime}, \
${1/innerData[i].lifetime}`;\n      \
context.fillRect(...innerData[i].coordinates);\n      //a rectangle gets \
older\n      innerData[i].lifetime = innerData[i].lifetime + 0.2;\n    }\n\n  \
  //sync to the browser's frame rate\n    env.local.uid = \
requestAnimationFrame(animate);\n  }\n\n  requestAnimationFrame(animate);\n}"\
, "display" -> "codemirror", "sign" -> "burgundy-e8f61", 
    "props" -> <|"hidden" -> False|>|>, 
   <|"id" -> "a5b639a1-f9fc-4087-add5-3a0584a763f7", "type" -> "output", 
    "data" -> "\n//global function\nwindow.getRandomInt = (max) => {\n  \
return Math.floor(Math.random() * max);\n}\n\ncore.ArrayDraw = async (args, \
env) => {\n  const canvas = document.createElement('canvas');\n  canvas.width \
= 300;\n  canvas.height = 300;\n  \n  //append our canvas to the provided \
DOM\n  env.element.appendChild(canvas);\n  \n  let context = \
canvas.getContext(\"2d\");\n  \n  //use local memory to store the canvas\n  \
env.local.ctx = context;\n\n  //store the data in JS\n  const innerData = \
[];\n  env.local.innerData = innerData;\n\n  const array = await \
interpretate(args[0], env);\n  \n  const width = array.length ;\n  const \
height = array[0].length;\n  \n  array.forEach((row, i) => {\n    \
row.forEach((cell, j) => {\n      if (cell < 1) return;\n\n      //add new \
data to the local store\n      innerData.push({\n        coordinates: \
[Math.floor(i * (300/width))-1, Math.floor(j * (300/height))-1, \
Math.floor((300/width)-1), Math.floor((300/height)-1)],\n        lifetime: \
1,\n      });\n\n      //limit the number of points\n      if \
(innerData.length > 30*30) innerData.shift();\n    });\n  });\n\n  \
//animation function\n  function animate() {\n    context.fillStyle = \
\"white\";\n    context.fillRect(0, 0, 300, 300);\n\n    //draw all data from \
the store and fade it based on the lifetime\n    for (let i=0; \
i<innerData.length; ++i) {\n      context.fillStyle = \
`rgba(${255/innerData[i].lifetime},0,${255 - 255/innerData[i].lifetime}, \
${1/innerData[i].lifetime}`;\n      \
context.fillRect(...innerData[i].coordinates);\n      //a rectangle gets \
older\n      innerData[i].lifetime = innerData[i].lifetime + 0.2;\n    }\n\n  \
  //sync to the browser's frame rate\n    env.local.uid = \
requestAnimationFrame(animate);\n  }\n\n  requestAnimationFrame(animate);\n}"\
, "display" -> "js", "sign" -> "burgundy-e8f61", 
    "props" -> <|"hidden" -> False|>|>, 
   <|"id" -> "6264ae28-37c4-4cf7-a8bc-600ed0c09fd8df9", "type" -> "input", 
    "data" -> ".md\nNow all data is stored inside the `env.local` variable, \
which is unique for each instance.\n\nThen to call it like a proper Wolfram \
Function, we need to wrap it into", "display" -> "codemirror", 
    "sign" -> "burgundy-e8f61", "props" -> <|"hidden" -> True|>|>, 
   <|"id" -> "0acbdc0e-61f1-4c69-af1f-f39c425e786d", "type" -> "output", 
    "data" -> "\nNow all data is stored inside the `env.local` variable, \
which is unique for each instance.\n\nThen to call it like a proper Wolfram \
Function, we need to wrap it into", "display" -> "markdown", 
    "sign" -> "burgundy-e8f61", "props" -> <|"hidden" -> False|>|>, 
   <|"id" -> "c6b0d645-73d5-4152-b50d-f7aae7612df4df9", "type" -> "input", 
    "data" -> "gameOfLife = {224, {2, {{2, 2, 2}, {2, 1, 2}, {2, 2, 2}}}, {1, \
1}};\nboard = RandomInteger[1, {20, \
20}];\nCreateFrontEndObject[ArrayDraw[board = \
Last[CellularAutomaton[gameOfLife, board, {{0, 1}}]]]]", 
    "display" -> "codemirror", "sign" -> "burgundy-e8f61", 
    "props" -> <|"hidden" -> False|>|>, 
   <|"id" -> "25353030-424b-46d7-bddf-67b14a39a998", "type" -> "output", 
    "data" -> "FrontEndExecutable[\"ab47f5bd-0aeb-471b-9411-963c9a792c5d\"]", 
    "display" -> "codemirror", "sign" -> "burgundy-e8f61", 
    "props" -> <|"hidden" -> False|>|>, 
   <|"id" -> "c6c13f45-6405-4aaa-aede-b085fd1781cadf9", "type" -> "input", 
    "data" -> ".md\nYou __can copy and paste__, since this is a proper \
frontend object.\n\nHowever, there is much more we need to do as well. ", 
    "display" -> "codemirror", "sign" -> "burgundy-e8f61", 
    "props" -> <|"hidden" -> True|>|>, 
   <|"id" -> "b8d0ff94-e2ae-4f22-a2f2-b1d780e43e39", "type" -> "output", 
    "data" -> "\nYou __can copy and paste__, since this is a proper frontend \
object.\n\nHowever, there is much more we need to do as well. ", 
    "display" -> "markdown", "sign" -> "burgundy-e8f61", 
    "props" -> <|"hidden" -> False|>|>, 
   <|"id" -> "adde46e1-9d29-4e25-bb56-ce874a98ac22df9", "type" -> "input", 
    "data" -> " ", "display" -> "codemirror", "sign" -> "burgundy-e8f61", 
    "props" -> <|"hidden" -> False|>|>, 
   <|"id" -> "6f060451-6916-43e5-b6ab-bec6c1cf205fdf9", "type" -> "input", 
    "data" -> ".md\n## Cleanning up method\nOnce you delete this widget or \
object (i dunno how to call it), we should take care about animation loop", 
    "display" -> "codemirror", "sign" -> "burgundy-e8f61", 
    "props" -> <|"hidden" -> True|>|>, 
   <|"id" -> "5abae055-b318-471f-8219-459620e29e89", "type" -> "output", 
    "data" -> "\n## Cleanning up method\nOnce you delete this widget or \
object (i dunno how to call it), we should take care about animation loop", 
    "display" -> "markdown", "sign" -> "burgundy-e8f61", 
    "props" -> <|"hidden" -> False|>|>, 
   <|"id" -> "4eb22dfb-2272-413b-b9cc-42a6988ac906df9", "type" -> "input", 
    "data" -> ".js\ncore.ArrayDraw.destroy = async (args, env) => {\n  \
//remove animation loop\n  cancelAnimationFrame(env.local.uid);\n  //make \
shure that all other nested object will do the same\n  interpretate(args[0], \
env);\n}", "display" -> "codemirror", "sign" -> "burgundy-e8f61", 
    "props" -> <|"hidden" -> False|>|>, 
   <|"id" -> "fb002555-93a2-45ff-847b-ed88cc26b6c0", "type" -> "output", 
    "data" -> "\ncore.ArrayDraw.destroy = async (args, env) => {\n  //remove \
animation loop\n  cancelAnimationFrame(env.local.uid);\n  //make shure that \
all other nested object will do the same\n  interpretate(args[0], env);\n}", 
    "display" -> "js", "sign" -> "burgundy-e8f61", 
    "props" -> <|"hidden" -> False|>|>, 
   <|"id" -> "817ef267-a5e3-4db8-a677-761f9393f831df9", "type" -> "input", 
    "data" -> ".md\n## Update method\nThere is no need to reevaluate the cell \
in order to update the canvas, we have a special method for that", 
    "display" -> "codemirror", "sign" -> "burgundy-e8f61", 
    "props" -> <|"hidden" -> True|>|>, 
   <|"id" -> "1a466bb1-0478-434d-9f23-3ee6b7dcf5c0", "type" -> "output", 
    "data" -> "\n## Update method\nThere is no need to reevaluate the cell in \
order to update the canvas, we have a special method for that", 
    "display" -> "markdown", "sign" -> "burgundy-e8f61", 
    "props" -> <|"hidden" -> False|>|>, 
   <|"id" -> "9a9f8c26-d27d-40d2-b6a3-6b42a959b690df9", "type" -> "input", 
    "data" -> ".js\ncore.ArrayDraw.update = async (args, env) => {\n  \
//restore the context\n  let context = env.local.ctx;\n  const innerData = \
env.local.innerData;\n  //get new data\n  const array = await \
interpretate(args[0], env);\n  \n  const width = array.length ;\n  const \
height = array[0].length;\n  //update\n  array.forEach((row, i) => {\n    \
row.forEach((cell, j) => {\n      if (cell < 1) return;\n\n      //add new \
data to the local store\n      innerData.push({\n        coordinates: \
[Math.floor(i * (300/width))-1, Math.floor(j * (300/height))-1, \
Math.floor((300/width)-1), Math.floor((300/height)-1)],\n        lifetime: \
1,\n      });\n\n      //limit the number of points\n      if \
(innerData.length > 30*30) innerData.shift();\n    });\n  });\n}", 
    "display" -> "codemirror", "sign" -> "burgundy-e8f61", 
    "props" -> <|"hidden" -> False|>|>, 
   <|"id" -> "55682a6a-5601-4a5d-942c-742f25f034a9", "type" -> "output", 
    "data" -> "\ncore.ArrayDraw.update = async (args, env) => {\n  //restore \
the context\n  let context = env.local.ctx;\n  const innerData = \
env.local.innerData;\n  //get new data\n  const array = await \
interpretate(args[0], env);\n  \n  const width = array.length ;\n  const \
height = array[0].length;\n  //update\n  array.forEach((row, i) => {\n    \
row.forEach((cell, j) => {\n      if (cell < 1) return;\n\n      //add new \
data to the local store\n      innerData.push({\n        coordinates: \
[Math.floor(i * (300/width))-1, Math.floor(j * (300/height))-1, \
Math.floor((300/width)-1), Math.floor((300/height)-1)],\n        lifetime: \
1,\n      });\n\n      //limit the number of points\n      if \
(innerData.length > 30*30) innerData.shift();\n    });\n  });\n}", 
    "display" -> "js", "sign" -> "burgundy-e8f61", 
    "props" -> <|"hidden" -> False|>|>, 
   <|"id" -> "f4b89f7e-edca-4a12-b011-6982bf5c230fdf9", "type" -> "input", 
    "data" -> ".md\nNow we can check the result by rewritting the update \
cycle in WL in a much shorter way", "display" -> "codemirror", 
    "sign" -> "burgundy-e8f61", "props" -> <|"hidden" -> True|>|>, 
   <|"id" -> "4d927703-f5b1-41ae-aca9-ce28cb6b6923", "type" -> "output", 
    "data" -> "\nNow we can check the result by rewritting the update cycle \
in WL in a much shorter way", "display" -> "markdown", 
    "sign" -> "burgundy-e8f61", "props" -> <|"hidden" -> False|>|>, 
   <|"id" -> "6adf6c30-2040-4442-bc02-14a2ec0513f7df9", "type" -> "input", 
    "data" -> "gameOfLife = {224, {2, {{2, 2, 2}, {2, 1, 2}, {2, 2, 2}}}, {1, \
1}};\nboard = RandomInteger[1, {20, \
20}];\nCreateFrontEndObject[ArrayDraw[Hold[board]]]", 
    "display" -> "codemirror", "sign" -> "burgundy-e8f61", 
    "props" -> <|"hidden" -> False|>|>, 
   <|"id" -> "c9f13fc9-0719-4468-aa6c-a768f09a4fa0", "type" -> "output", 
    "data" -> "FrontEndExecutable[\"0fbc17cd-4cd3-46ec-878e-0693f6e96684\"]", 
    "display" -> "codemirror", "sign" -> "burgundy-e8f61", 
    "props" -> <|"hidden" -> False|>|>, 
   <|"id" -> "955d6278-f856-4b1c-94d0-21ac8f02e9bddf9", "type" -> "input", 
    "data" -> ".md\nSo it just updates our variable `board` without thinking \
of redrawing the canvas", "display" -> "codemirror", 
    "sign" -> "burgundy-e8f61", "props" -> <|"hidden" -> True|>|>, 
   <|"id" -> "7d5bc83c-c211-44cf-a6a3-2d7c846681b6", "type" -> "output", 
    "data" -> "\nSo it just updates our variable `board` without thinking of \
redrawing the canvas", "display" -> "markdown", "sign" -> "burgundy-e8f61", 
    "props" -> <|"hidden" -> False|>|>, 
   <|"id" -> "1517ca46-5aad-46ea-88d6-722bc0f82ffcdf9", "type" -> "input", 
    "data" -> "Do[\n  board = Last[CellularAutomaton[gameOfLife, board, {{0, \
1}}]];\n  Pause[0.1];\n, {i, 100}]", "display" -> "codemirror", 
    "sign" -> "burgundy-e8f61", "props" -> <|"hidden" -> False|>|>, 
   <|"id" -> "d24debcf-1c3b-4e9d-98d8-8a844074263edf9", "type" -> "input", 
    "data" -> " ", "display" -> "codemirror", "sign" -> "burgundy-e8f61", 
    "props" -> <|"hidden" -> False|>|>, 
   <|"id" -> "70b43f9e-e063-4dd2-863e-79bd9b642d11df9", "type" -> "input", 
    "data" -> ".md\n## Final touch\nIt is possible to get rid of a wrapper \
`CreateFrontEndObject`, if we register the function", 
    "display" -> "codemirror", "sign" -> "burgundy-e8f61", 
    "props" -> <|"hidden" -> True|>|>, 
   <|"id" -> "90461e31-2ce4-4d67-a06d-5211ab943ae8", "type" -> "output", 
    "data" -> "\n## Final touch\nIt is possible to get rid of a wrapper \
`CreateFrontEndObject`, if we register the function", 
    "display" -> "markdown", "sign" -> "burgundy-e8f61", 
    "props" -> <|"hidden" -> False|>|>, 
   <|"id" -> "2ec54a03-d104-45c2-b6d2-50bdba27072edf9", "type" -> "input", 
    "data" -> "RegisterWebObject[ArrayDraw];", "display" -> "codemirror", 
    "sign" -> "burgundy-e8f61", "props" -> <|"hidden" -> False|>|>, 
   <|"id" -> "7065219e-3e55-4fbb-80ef-84dabcd0465fdf9", "type" -> "input", 
    "data" -> 
     ".md\nSince it is registered, it is possible to call it as it is", 
    "display" -> "codemirror", "sign" -> "burgundy-e8f61", 
    "props" -> <|"hidden" -> True|>|>, 
   <|"id" -> "60b594e0-5315-48b3-a565-b53ec1cd585c", "type" -> "output", 
    "data" -> "\nSince it is registered, it is possible to call it as it is", 
    "display" -> "markdown", "sign" -> "burgundy-e8f61", 
    "props" -> <|"hidden" -> False|>|>}, "serializer" -> "jsfn3"|>
