vim.opt.relativenumber = true
vim.filetype.add({extension = {wgsl = "wgsl"}})

-- refresh file buffer when it changes on disk
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})
