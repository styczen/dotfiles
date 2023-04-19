local comment_ok, comment = pcall(require, 'Comment')
if not comment_ok then
    vim.notify('"comment" not found', vim.log.levels.warn)
    return
end
local ts_ctx_comment_ok, ts_ctx_comment = pcall(require, 'ts_context_commentstring.integrations.comment_nvim')
if not ts_ctx_comment_ok then
    vim.notify('"ts_context_commentstring" not found', vim.log.levels.warn)
    return
end

comment.setup({
    pre_hook = ts_ctx_comment.create_pre_hook(),
})
