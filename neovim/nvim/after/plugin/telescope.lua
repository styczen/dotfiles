local ok, telescope = pcall(require, 'telescope')
if not ok then
    vim.notify('"telescope" not found')
    return
end
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
            }
        }
    }
})

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
-- vim.keymap.set('n', '<leader>ps', function()
-- 	builtin.grep_string({ search = vim.fn.input('Grep > ') });
-- end)
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
