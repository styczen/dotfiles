vim.o.background = 'dark'

local status_ok, vscode = pcall(require, "vscode")
if not status_ok then
    vim.notify("Cannot load vscode plugin")
    return
end

local c = require('vscode.colors')
vscode.setup({
    -- Enable transparent background
    transparent = true,

    -- Enable italic comment
    italic_comments = true,

    -- Disable nvim-tree background color
    disable_nvimtree_bg = true,

    -- Override highlight groups (see ./lua/vscode/theme.lua)
    group_overrides = {
        -- this supports the same val table as vim.api.nvim_set_hl
        -- use colors from this colorscheme by requiring vscode.colors!
        GitSignsChange = { fg = c.vscMediumBlue, bg = 'NONE' }
    }
})
