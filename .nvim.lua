vim.opt.colorcolumn = "120"

local imported, flutter_tools = pcall(require, "flutter-tools")
if (not imported) then
  return
end

flutter_tools.setup({
  fvm = true,
  debugger = {
    enabled = true,
    run_via_dap = true,
    -- exception_breakpoints = {}
  },
  lsp = {
    settings = {
      showTodos = true,
      renameFilesWithClasses = "always",
      completeFunctionCalls = true,
      enableSnippets = true,
      updateImportsOnRename = true,
      lineLength = 120,
      analysisExcludedFolders = {
        ".bin/**",
        "lib/generated/**",
        "lib/**.g.dart",
        "lib/**.freezed.dart",
      },
    },
  },
})
