local ok, gitsigns = pcall(require, 'gitsigns')
if not ok then
    vim.notify('"gitsigns" not found')
    return
end

gitsigns.setup()

