local default_config = {
  commands = { enable = true },
  autocmd = { enable = true },
}

local config = {
  options = {},
}

config.load = function(user_config)
  config.options = vim.tbl_deep_extend("force", default_config, user_config or {})

  if next(config.options) then
    if config.options.commands.enable then
      require("inlay-hints.commands")
    end

    if config.options.autocmd.enable then
      require("inlay-hints.utils").enable_inlay_hints_autocmd()
    end
  end
end

return config
