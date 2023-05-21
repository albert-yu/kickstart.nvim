vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  init = function()
    vim.keymap.set('n', '<leader>o', '<Cmd>Neotree toggle<CR>')
  end,
  config = function ()
    require('neo-tree').setup {}
  end
}