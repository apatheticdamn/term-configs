local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- Add LazyVim and import its plugins
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
      opts = {
        colorscheme = "solarized-osaka", -- Default colorscheme
      },
    },
    -- Import/override with your plugins
    { import = "plugins" },
    -- Add vim-tmux-navigator
    { "christoomey/vim-tmux-navigator" },
    -- Add NvimTree plugin
    { "kyazdani42/nvim-tree.lua", requires = { "kyazdani42/nvim-web-devicons" } },
  },
  defaults = {
    lazy = false, -- Custom plugins will load during startup
    version = false, -- Always use the latest git commit
  },
  install = { colorscheme = { "tokyonight", "habamax" } }, -- Fallback colorschemes
  checker = {
    enabled = true, -- Check for plugin updates periodically
    notify = false, -- Do not notify on updates
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
