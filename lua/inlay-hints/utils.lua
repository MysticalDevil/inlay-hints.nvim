local M = {}

local inlay_hint = vim.lsp.inlay_hint

-- Setup inlay hints feature for supported LSP
---@param client (table|nil)
---@param bufnr (integer|nil)
local function setup_inlay_hints(client, bufnr)
  if not client then
    vim.notify_once("LSP inlay hints attached failed: nil client.", vim.log.levels.ERROR)
    return
  end

  -- Filtering unstable LSPs
  local unstable = {
    phpactor = true,
    tsserver = false,
  }
  if unstable[client.name] then
    vim.notify(("Skip inlay hints for LSP: %s"):format(client.name), vim.log.levels.ERROR)
    return
  end

  local ok = client:supports_method("textDocument/inlayHint") or client.server_capabilities.inlayHintProvider
  if not ok then
    -- vim.notify(("Client do not support inlay hints: %s"):format(client.name), vim.log.levels.WARN)
    return
  end

  if vim.b[bufnr].inlay_hints_enabled then
    return
  end

  local function setup_inlay_hints_impl()
    vim.b[bufnr].inlay_hints_enabled = true

    pcall(function()
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end)
  end

  if client.name == "lua_ls" then
    -- Work around a lua_ls bug.
    -- Without this, inlay hints don't appear until scrolling or editing.
    vim.defer_fn(setup_inlay_hints_impl, 500)
  else
    setup_inlay_hints_impl()
  end
end

---@param args table
local function lsp_attach_inlay_hints(args)
  if not (args.data and args.data.client_id) then
    return
  end

  local bufnr = args.buf
  local client = vim.lsp.get_client_by_id(args.data.client_id)

  setup_inlay_hints(client, bufnr)
end

function M.on_attach(client, bufnr)
  setup_inlay_hints(client, bufnr)
end

-- Provide a autocmd to enable inlay hints when the LspAttach event is actived
function M.enable_inlay_hints_autocmd()
  vim.api.nvim_create_augroup("LspSetup_Inlayhints", { clear = true })
  vim.cmd.highlight("default link LspInlayHint Comment")

  vim.api.nvim_create_autocmd("LspAttach", {
    group = "LspSetup_Inlayhints",
    callback = function(args)
      lsp_attach_inlay_hints(args)
    end,
  })
end

function M.toggle_inlay_hints()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
end

function M.enable_inlay_hints()
  if not inlay_hint.is_enabled() then
    inlay_hint.enable(true, nil)
  end
end

function M.disable_inlay_hints()
  if inlay_hint.is_enabled() then
    inlay_hint.enable(false, nil)
  end
end

return M
