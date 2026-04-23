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

## [0.0.6] - 2024-02

### Added

- Added `rustaceanvim` inlay hints configuration example.

## [0.0.5] - 2024-02

### Changed

- Refactored main plugin logic for clarity.
- Restructured README and fixed grammar.

### Added

- Added workspace `.luarc.json` and `neovim.yml` for development.

### Fixed

- Fixed deprecated function usage.
- Fixed example code in documentation.

## [0.0.4] - 2024-01

### Added

- Added `vtsls` configuration documentation.
- Added `svelte-language-server` configuration documentation.

### Fixed

- Fixed gopls hints setting example.
- Fixed basedpyright setup typo in README.
- Removed some error snippets from documentation.

## [0.0.3] - 2024-01

### Added

- Added basedpyright configuration.
- Added omnisharp inlay hints documentation.

## [0.0.2] - 2024-01

### Fixed

- Fixed `vim.lsp.inlay_hint.enable()` API changes in Neovim 0.10+.

### Added

- Added denols and eclipse.jdt.ls configuration documentation.

## [0.0.1] - 2024-01

### Added

- Initial release.
- Auto-enable inlay hints on `LspAttach`.
- `:InlayHintsToggle`, `:InlayHintsEnable`, `:InlayHintsDisable` user commands.
- Kotlin LSP configuration documentation.

[0.0.7]: https://github.com/MysticalDevil/inlay-hints.nvim/compare/v0.0.6...v0.0.7
[0.0.6]: https://github.com/MysticalDevil/inlay-hints.nvim/compare/v0.0.5...v0.0.6
[0.0.5]: https://github.com/MysticalDevil/inlay-hints.nvim/compare/v0.0.4...v0.0.5
[0.0.4]: https://github.com/MysticalDevil/inlay-hints.nvim/compare/v0.0.3...v0.0.4
[0.0.3]: https://github.com/MysticalDevil/inlay-hints.nvim/compare/v0.0.2...v0.0.3
[0.0.2]: https://github.com/MysticalDevil/inlay-hints.nvim/compare/v0.0.1...v0.0.2
[0.0.1]: https://github.com/MysticalDevil/inlay-hints.nvim/releases/tag/v0.0.1
