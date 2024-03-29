local null_ls_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_ok then
    vim.notify('"null_ls" not found', vim.log.levels.WARN)
    return
end

local formatting = null_ls.builtins.formatting;
local diagnostics = null_ls.builtins.diagnostics;

null_ls.setup({
    sources = {
        -- Formatters
        formatting.prettier,
        -- formatting.clang_format,

        -- Linters
        diagnostics.eslint,
    },
})
