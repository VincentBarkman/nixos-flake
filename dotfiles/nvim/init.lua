require("options")
require("config.lazy")

vim.cmd("colorscheme onedark")

vim.opt.expandtab = true

vim.wo.number = true

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

vim.keymap.set("i", "<Tab>", function()
  return string.rep(" ", vim.opt.shiftwidth:get())
end, { expr = true, silent = true })


vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

vim.cmd("colorscheme onedark")
