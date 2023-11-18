local create_user_command = vim.api.nvim_create_user_command

create_user_command(
  "InlayHintsToggle",
  require("inlay-hints.utils").toggle_inlay_hints,
  { desc = "Enable/Disable inlay hints on current buffer" }
)
create_user_command(
  "InlayHintsEnable",
  require("inlay-hints.utils").enable_inlay_hints,
  { desc = "Enable/Disable inlay hints on current buffer" }
)
create_user_command(
  "InlayHintsDisable",
  require("inlay-hints.utils").disable_inlay_hints,
  { desc = "Enable/Disable inlay hints on current buffer" }
)
