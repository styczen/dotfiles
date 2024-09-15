-- Automatically install packer
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        print('Installing packer close and reopen Neovim...')
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer()

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- TODO: Write it in Lua
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

-- Use a protected call so we don't error out on first use
local packer_ok, packer = pcall(require, 'packer')
if not packer_ok then
    vim.notify('"packer" not found')
    return
end

-- Install your plugins here
return packer.startup(function(use)
    use('wbthomason/packer.nvim')
    use('Mofiqul/vscode.nvim')
    use({
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        requires = { {'nvim-lua/plenary.nvim'} }
    })
    use({
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    })
    use('lewis6991/gitsigns.nvim')

    -- LSP Support
    use('neovim/nvim-lspconfig')
    use('williamboman/mason.nvim')
    use('williamboman/mason-lspconfig.nvim')
    use({
        'jose-elias-alvarez/null-ls.nvim',
        requires = { "nvim-lua/plenary.nvim" },
    })

    -- Autocompletion
    use('hrsh7th/nvim-cmp')
    use('hrsh7th/cmp-nvim-lsp')
    use('L3MON4D3/LuaSnip')
    use('saadparwaiz1/cmp_luasnip')
    -- use('hrsh7th/cmp-buffer')
    -- use('hrsh7th/cmp-path')
    -- use('hrsh7th/cmp-nvim-lua')

    -- Snippets
    -- use('rafamadriz/friendly-snippets')

    -- Context aware commenting e.g. TSX/JSX braces
    use('numToStr/Comment.nvim')
    use('JoosepAlviste/nvim-ts-context-commentstring')

    -- LaTeX
    use("lervag/vimtex")

    if packer_bootstrap then
        require('packer').sync()
    end
end)
