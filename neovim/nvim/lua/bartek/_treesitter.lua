local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

configs.setup {
    ensure_installed = "all",
    sync_install = false,
    ignore_install = { "" }, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = true,
    },
    indent = { enable = true, disable = { "yaml" } },
}

local status_ok, treesitter_context = pcall(require, "treesitter-context")
if not status_ok then
    return
end

treesitter_context.setup({
    enable = true,
})

