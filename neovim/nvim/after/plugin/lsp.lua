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

-- LSP setup
local on_attach = function(_, bufnr)
    local keymap = function(mode, keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
    end

    keymap('n', '<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    keymap('n', '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    keymap('n', 'gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    keymap('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]efinition')
    keymap('n', 'gr', builtin.lsp_references, '[G]oto [R]eferences')
    keymap('n', 'gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    keymap('n', 'gl', vim.diagnostic.open_float, '[O]pen [F]loating window')
    keymap('n', '<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    keymap('n', '<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
    keymap('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    keymap('n', '<leader>[d', vim.diagnostic.goto_prev, 'Move to the previous diagnostic')
    keymap('n', '<leader>]d', vim.diagnostic.goto_next, 'Move to the next diagnostic')

    -- See `:help K` for why this keymap
    keymap('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
    keymap('n', '<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
--    keymap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
--    keymap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    keymap('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    keymap('v', '<leader>f', '<cmd>lua vim.lsp.buf.format()<CR><ESC>', '[F]ormat highlighted text')
end

local servers = {
    rust_analyzer = {},
    tsserver = {},
--    pylsp = {
--        settings = {
--            pylsp = {
--                plugins = {
--                    pycodestyle = {
--                        maxLineLength = 100
--                    }
--                }
--            }
--        }
--    },
    pylsp = {
        settings = {
            pylsp = {
                plugins = {
                    pycodestyle = {
                        maxLineLength = 120
                    },
                    flake8 = {
                        maxLineLength = 120
                    }
                }
            }
        }
    },
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = {
                globals = { "vim" }
            },
        },
    },
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
