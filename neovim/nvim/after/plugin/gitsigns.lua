local ok, gitsigns = pcall(require, 'gitsigns')
if not ok then
    vim.notify('"gitsigns" not found', vim.log.levels.WARN)
    return
end

gitsigns.setup()

