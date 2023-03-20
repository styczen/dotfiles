vim.o.background = 'dark'

local ok, vscode = pcall(require, 'vscode')
if not ok then
    vim.notify('"vscode" not found')
    return
end

local c = require('vscode.colors').get_colors()
vscode.setup({
    -- Enable transparent background
    transparent = true,

    -- Enable italic comment
    italic_comments = true,

    -- Disable nvim-tree background color
    disable_nvimtree_bg = true,

    -- Override highlight groups
    group_overrides = {
        -- this supports the same val table as vim.api.nvim_set_hl
        -- use colors from this colorscheme by requiring vscode.colors!
        GitSignsChange = { fg = c.vscMediumBlue, bg = 'NONE' }
    }
})
vscode.load()
