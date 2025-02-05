(* ::Package:: *)

PacletObject[
  <|
    "Name" -> "JerryI/WolframJSFrontend",
    "Description" -> "Implementation of web-frontend for Wolfram Engine",
    "Creator" -> "Kirill Vasin",
    "License" -> "MIT",
    "PublisherID" -> "JerryI",
    "Version" -> "1.0.0",
    "WolframVersion" -> "12+",
    "Extensions" -> {
      {
        "Kernel",
        "Root" -> "Kernel",
        "Context" -> {
          {"JerryI`WolframJSFrontend`", "Init.wl"}, 
          {"JerryI`WolframJSFrontend`Cells`", "Cells.wl"}, 
          {"JerryI`WolframJSFrontend`Evaluator`", "Evaluator.wl"}, 
          {"JerryI`WolframJSFrontend`Notebook`", "Notebook.wl"}, 
          {"JerryI`WolframJSFrontend`Kernel`", "Kernel.wl"}, 
          {"JerryI`WolframJSFrontend`Utils`", "Utils.wl"}, 
          {"JerryI`WolframJSFrontend`WebObjects`", "WebObjects.wl"}, 
          {"JerryI`WolframJSFrontend`Colors`", "Colors.wl"},
          {"JerryI`WolframJSFrontend`Dev`", "Dev.wl"},
          {"JerryI`WolframJSFrontend`Remote`", "Remote.wl"},
          {"JerryI`WolframJSFrontend`Events`", "Events.wl"},
          {"JerryI`WolframJSFrontend`WSPDynamicsExtension`", "WSPDynamicsExtension.wl"},

          {"JerryI`WolframJSFrontend`Packages`", "Packages.wl"}
        }
      },
      {"Documentation", "Language" -> "English"},
      {
        "Asset",
        "Assets" -> {
          {"webgui", "public"}
        }
      }
    }
  |>
]
