local M = {}

local inlay_hint = vim.lsp.inlay_hint

-- Proxy LSP names, which not provide general LSP features
local proxy_lsps = {
  ["null-ls"] = true,
  ["efm"] = true,
  ["emmet_ls"] = true,
  ["eslint"] = true,
  ["cssmodule_ls"] = true,
}

-- Determine whether the obtained LSP is a proxy LSP
---@param name string
---@return boolean
function M.not_proxy_lsp(name)
  return not proxy_lsps[name]
end

-- Setup inlay hints feature for supported LSP
---@param client (table|nil)
---@param bufnr (integer|nil)
local function setup_inlay_hints(client, bufnr)
  if not client then
    vim.notify_once("LSP inlay hints attached failed: nil client.", vim.log.levels.ERROR)
    return
  end

  if client.name == "zls" then
    vim.g.zig_fmt_autosave = 1
  end

  if client:supports_method("textDocument/inlayHint") or client.server_capabilities.inlayHintProvider then
    inlay_hint.enable(true, { bufnr = bufnr })
  end
end

---@param args table
local function lsp_attach_inlay_hints(args)
  if not (args.data and args.data.client_id) then
    return
  end

  local bufnr = args.buf
  local client = vim.lsp.get_client_by_id(args.data.client_id)

  if client and M.not_proxy_lsp(client.name) then
    setup_inlay_hints(client, bufnr)
  end
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
  if inlay_hint.is_enabled() then
    inlay_hint.enable(false, nil)
  else
    inlay_hint.enable(true, nil)
  end
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
