local ok, configs = pcall(require, 'nvim-treesitter.configs')
if not ok then
    vim.notify('"nvim-treesitter.configs" not found', vim.log.levels.WARN)
    return
end

configs.setup {
    ensure_installed = {
        'python',
        'rust',
        'c',
        'cpp',
        'lua',
        'vim',
        'markdown',
        'markdown_inline',
        'bash',
        'tsx',
        'json',
        'cmake',
        'xml',
        'typescript',
        'gitcommit',
        'gitignore',
        'vimdoc',
        'make',
        -- 'bibtex',
        'scss',
        -- 'latex',
        'yaml',
        'tmux',
        'csv',
        'html',
        'toml',
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    highlight = {
        enable = true,
        disable = { 'latex', 'bibtex' },

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}
