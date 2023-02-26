local config = {
--    virtual_text = false,
--    signs = true,
--    update_in_insert = false,
    underline = false,
    severity_sort = true,
    float = {
--        focusable = false,
--        style = 'minimal',
        severity_sort = true,
--        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
}
vim.diagnostic.config(config)
