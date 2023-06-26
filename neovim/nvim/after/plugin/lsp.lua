local mason_ok, mason = pcall(require, 'mason')
if not mason_ok then
    vim.notify('"mason" not found', vim.log.levels.WARN)
    return
end
local mason_lsp_config_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lsp_config_ok then
    vim.notify('"mason-lspconfig" not found', vim.log.levels.WARN)
    return
end
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_nvim_lsp_ok then
    vim.notify('"cmp_nvim_lsp" not found', vim.log.levels.WARN)
    return
end
local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_ok then
    vim.notify('"lspconfig" not found', vim.log.levels.WARN)
    return
end
local builtin_ok, builtin = pcall(require, 'telescope.builtin')
if not builtin_ok then
    vim.notify('"telescope.builtin" not found', vim.log.levels.WARN)
    return
end

local opts = { noremap=true, silent=true }
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- LSP setup
local on_attach = function(_, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gr', builtin.lsp_references, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols, bufopts)
    vim.keymap.set('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, bufopts)

    -- See `:help K` for why this keymap
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

    -- Lesser used LSP functionality
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)

    -- Selection formatting
    vim.keymap.set('v', '<leader>f', function()
        vim.lsp.buf.format()
        vim.api.nvim_input('<ESC>')
    end, bufopts)

    -- Whole file formatting
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)
end

local servers = {
    -- Rust
    rust_analyzer = {},

    -- Javascript/Typescript
    tsserver = {},

    -- Python
    pylsp = {
        pylsp = {
            plugins = {
                autopep8 = {
                    enabled = true,
                },
                pycodestyle = {
                    enabled = true,
                    maxLineLength = 100,
                },
                -- pyflakes = {
                --     enabled = false,
                -- },
                -- pydocstyle = {
                --     enabled = false,
                -- },
                -- jedi_completion = {
                --     enabled = true,
                -- },
                -- jedi_definition = {
                --     enabled = true,
                -- },
                -- jedi_hover = {
                --     enabled = true,
                -- },
                -- jedi_references = {
                --     enabled = true,
                -- },
                -- jedi_signature_help = {
                --     enabled = true,
                -- },
                -- jedi_symbols = {
                --     enabled = true,
                -- },
                -- mccabe = {
                --     enabled = false,
                -- },
                -- flake8 = {
                --     enabled = false,
                --     maxLineLength = 30,
                -- },
                -- yapf = {
                --     enabled = false,
                -- },
            }
        }
    },

    -- Lua
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = {
                globals = { "vim" }
            },
        },
    },

    -- C++
    clangd = {},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

mason.setup()
mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers)
})

mason_lspconfig.setup_handlers({
    function(server_name)
        lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
        })
    end,
})
