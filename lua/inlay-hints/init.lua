if vim.fn.has("nvim-0.10") == 0 then
  vim.notify("This plugin only works with neovim 0.10+, please update your neovim version", vim.log.levels.ERROR)
  return
end

local M = {}

---Initialise the plugin with user configuration.
---@param user_config table|nil Optional user configuration. See |inlay-hints.config|.
M.setup = function(user_config)
  vim.validate({ user_config = { user_config, "table", true } })
  require("inlay-hints.config").load(user_config)
end

---Attach inlay hints for the given LSP client and buffer.
---Intended for use inside an LSP `on_attach` callback.
---@param client vim.lsp.Client|nil The LSP client instance.
---@param bufnr integer|nil Buffer number (defaults to 0).
M.on_attach = require("inlay-hints.utils").on_attach

---Create the `LspSetup_Inlayhints` autocommand group and register
---an `LspAttach` autocmd that enables inlay hints automatically.
M.enable_inlay_hints_autocmd = require("inlay-hints.utils").enable_inlay_hints_autocmd

return M
