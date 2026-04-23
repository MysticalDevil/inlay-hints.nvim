# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [0.0.7] - 2026-04-23

### Added

- Added inlay hints configuration for **Ruby LSP**.
- Added `vtsls` (recommended TypeScript server) documentation.
- Added `denols`, `eclipse.jdt.ls`, `svelte-language-server`, `roslyn`, and **JetBrains official kotlin-lsp** configurations.
- Added `rustaceanvim` inlay hints configuration example.
- Added full EmmyLua annotations to all public APIs.

### Changed

- **Refactored core logic** for clarity and maintainability.
- **Replaced `pckr.nvim` and `nvim-lspconfig` examples** with Neovim 0.10+ built-in APIs (`vim.lsp.config`, `vim.pack.add`).
- **Moved LSP server configurations** from README to `docs/lsp-configurations.md` for easier maintenance.
- Restructured README with clearer purpose statement and manual setup example.
- `skip unstable LSP` notification downgraded from `ERROR` to `WARN`.

### Fixed

- **Fixed version check logic** — `vim.fn.has()` returns a number; the previous `not` check would never block the plugin on Neovim < 0.10.
- **Fixed `pcall` + flag ordering** — `inlay_hints_enabled` is now set only after `vim.lsp.inlay_hint.enable()` succeeds, preventing a state where retries are permanently skipped after a transient failure.
- **Fixed command registration repeatability** — `commands.lua` now exports a `setup()` function instead of running top-level registration, so commands are recreated correctly across multiple `setup()` calls.
- **Fixed crash on invalid config types** — passing `commands = false` or `autocmd = false` no longer crashes; the plugin now warns and falls back to the default.
- **Fixed user command descriptions** — `:InlayHintsEnable` and `:InlayHintsDisable` now have accurate descriptions instead of the generic "Enable/Disable" text.
- **Fixed lua_ls workaround** — deferred hint enabling to avoid hints not appearing until scroll/edit.
- **Fixed buffer-scoped filtering** for toggle/enable/disable commands.
- **Fixed TypeScript LSP name** in documentation (`ts_ls`).
- **Fixed gopls hints setting** example.
- **Fixed deprecated API usage** (`vim.lsp.inlay_hint.enable()` signature changes).

### Removed

- Removed incorrect / incomplete `basedpyright` config, then re-added with correct settings.
- Removed `pylyzer` documentation (feature is unstable).
- Removed meaningless `tsserver = false` entry from the unstable LSP filter table.

[0.0.7]: https://github.com/MysticalDevil/inlay-hints.nvim/compare/v0.0.6...v0.0.7
