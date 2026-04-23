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

---Validate a nested option field. If the user provided an invalid type,
---warn and fall back to the default value.
---@param key "commands"|"autocmd"
---@param default_val table
local function validate_option(key, default_val)
  local val = config.options[key]
  if type(val) ~= "table" then
    vim.notify(
      string.format("[inlay-hints] Invalid type for '%s' (expected table, got %s). Using default.", key, type(val)),
      vim.log.levels.WARN
    )
    config.options[key] = vim.deepcopy(default_val)
  end
end

---Load and merge user configuration, then initialise features.
---@param user_config inlay-hints.Config|nil User-provided partial configuration.
config.load = function(user_config)
  config.options = vim.tbl_deep_extend("force", default_config, user_config or {})

  validate_option("commands", default_config.commands)
  validate_option("autocmd", default_config.autocmd)

  if config.options.commands.enable then
    require("inlay-hints.commands").setup()
  end

  if config.options.autocmd.enable then
    require("inlay-hints.utils").enable_inlay_hints_autocmd()
  end
end

return config
