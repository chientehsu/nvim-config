require "conf"
if vim.g.neovide then
	-- Automatically CD to the project root whenever you open a file
    vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        local root_markers = { ".git", "Makefile", "*.ioc", "Core", ".root" }
        local root = vim.fs.find(root_markers, { upward = true, path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)) })[1]
        if root then
            vim.cmd("cd " .. vim.fs.dirname(root))
        end
    end,
})
end