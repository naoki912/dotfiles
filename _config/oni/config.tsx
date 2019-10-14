import * as React from "react"
import * as Oni from "oni-api"

export const activate = (oni: Oni.Plugin.Api) => {
  console.log("config activated")

  // Input
  //
  // Add input bindings here:
  //
  oni.input.bind("<c-enter>", () => console.log("Control+Enter was pressed"))

  //
  // Or remove the default bindings here by uncommenting the below line:
  //
  // oni.input.unbind("<c-p>")

  oni.input.unbindAll()
}

export const deactivate = (oni: Oni.Plugin.Api) => {
  console.log("config deactivated")
}

export const configuration = {
  activate,

  //"browser.zoomFactor": 2.0,

  "oni.useDefaultConfig": true,
  //"oni.bookmarks": ["~/Documents"],
  "oni.loadInitVim": true,
  "oni.hideMenu": true,

  //"editor.clipboard.enabled": false,
  "editor.fontSize": "18px",
  "editor.fontFamily": "Ricty Discord",

  // UI customizations
  "ui.colorscheme": "molokai",
  "ui.animations.enabled": true,
  "ui.fontSmoothing": "auto",
  "ui.fontSize": "18px",
  "ui.fontFamily": "Ricty Discord",

  //"statusbar.enabled": false,
  //"statusbar.fontSize": "16px",

  "tabs.mode": "native",

  "commandline.mode": false,

  //"wildmenu.mode": false,

  "sidebar.enabled": false,

  "experimental.markdownPreview.enabled": true,
}
