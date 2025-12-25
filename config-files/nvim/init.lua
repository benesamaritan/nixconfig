-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.g.clipboard = {
  name = 'WlClipboard',
  copy = {
    ['+'] = 'wl-copy',
    ['*'] = 'wl-copy',
  },
  paste = {
    ['+'] = 'wl-paste',
    ['*'] = 'wl-paste',
  },
  cache_enabled = 0,
}

vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
