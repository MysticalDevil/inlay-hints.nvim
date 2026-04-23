---Default and runtime configuration for inlay-hints.nvim.

---@class inlay-hints.Config
---@field commands { enable: boolean } Whether to create user commands (`InlayHintsToggle`, etc.).
---@field autocmd { enable: boolean } Whether to auto-enable inlay hints on `LspAttach`.

---Default configuration values.
---@type inlay-hints.Config
local default_config = {
  commands = { enable = true },
  autocmd = { enable = true },
}

---@class inlay-hints.ConfigModule
---@field options inlay-hints.Config Merged user + default configuration.
local config = {
  options = {},
}

---Load and merge user configuration, then initialise features.
---@param user_config inlay-hints.Config|nil User-provided partial configuration.
config.load = function(user_config)
  config.options = vim.tbl_deep_extend("force", default_config, user_config or {})

  if config.options.commands.enable then
    require("inlay-hints.commands")
  end

  if config.options.autocmd.enable then
    require("inlay-hints.utils").enable_inlay_hints_autocmd()
  end
end

return config
