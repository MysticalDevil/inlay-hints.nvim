if not vim.fn.has("nvim-0.10") then
  vim.notify(
    "This plugin only works with neovim 0.10+(nightly), please update your neovim version",
    vim.log.levels.ERROR
  )
  return
end

local M = {}

M.setup = function(user_config)
  vim.validate({ user_config = { user_config, "table", true } })
  require("inlay-hints").config.load(user_config)
end

M.on_attach = require("inlay-hints.utils").on_attach
M.enable_inlay_hints_autocmd = require("inlay-hints.utils").enable_inlay_hints_autocmd

return M
