local ok, lsp = pcall(require, 'lsp-zero')
if not ok then
    vim.notify('"lsp-zero" not found')
    return
end

lsp.preset({
    name = 'minimal',
    set_lsp_keymaps = true,
    manage_nvim_cmp = true,
    suggest_lsp_servers = false,
})

lsp.ensure_installed({
    'rust_analyzer',
    'pylsp',
    'tsserver',
    'lua_ls',
})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()
