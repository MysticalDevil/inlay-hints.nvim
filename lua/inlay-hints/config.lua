local default_config = {
  commands = { enable = true },
  autocmd = { enable = true },
}

local config = {
  options = {},
}

config.load = function(user_config)
  config.options = vim.tbl_deep_extend("force", default_config, user_config or {})
end

if config.options.commands.enable then
  require("inlay-hints.commands")
end

if config.options.autocmd.enable then
  require("inlay-hints.utils").enable_inlay_hints_autocmd()
end

return config
