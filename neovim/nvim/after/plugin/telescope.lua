local ok, telescope = pcall(require, 'telescope')
if not ok then
    vim.notify('"telescope" not found', vim.log.levels.WARN)
    return
end
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local previewers = require('telescope.previewers')

local new_maker = function(filepath, bufnr, opts)
    opts = opts or {}
    filepath = vim.fn.expand(filepath)
    vim.loop.fs_stat(filepath, function(_, stat)
        if not stat then return end
        if stat.size > 1000000 then
            return
        else
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
        end
    end)
end

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
            }
        },
        buffer_previewer_maker = new_maker,
    }
})

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
vim.keymap.set('n', '<leader>gs', builtin.grep_string, {})
vim.keymap.set('n', '<leader>bb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>dd', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>gg', builtin.git_status, {})
