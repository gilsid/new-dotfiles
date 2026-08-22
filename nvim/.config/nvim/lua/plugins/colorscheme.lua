return {
  -- Utama (load saat startup, priority 1000) — match sistem Gruvbox Material
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
        transparent_mode = true,
        palette_overrides = { dark0_hard = "#1d2021" },
      })
    end,
  },
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_transparent_background = 1
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
      })
    end,
  },
  -- Fallback LazyVim default
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = { transparent = true },
  },

  -- Sisanya lazy=true — tetap bisa dipilih via <leader>th, tapi tidak load saat startup (hemat ~150ms)
  {
    "neanias/everforest-nvim",
    name = "everforest",
    lazy = true,
    config = function()
      require("everforest").setup({
        background = "hard",
        ui_contrast = "high",
        transparent_background = true,
      })
    end,
  },
  { "shaunsingh/nord.nvim", lazy = true },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    config = function()
      require("kanagawa").setup({
        theme = "dragon",
        transparent = true,
        background = { dark = "dragon" },
      })
    end,
  },
  { "rose-pine/neovim", name = "rose-pine", lazy = true },
  { "navarasu/onedark.nvim", opts = { transparent = true }, lazy = true },
  { "EdenEast/nightfox.nvim", lazy = true },
  { "scottmckendry/cyberdream.nvim", lazy = true },
  { "savq/melange-nvim", lazy = true },
  { "projekt0n/github-nvim-theme", lazy = true },
  { "nyoom-engineering/oxocarbon.nvim", lazy = true },
  { "Mofiqul/dracula.nvim", opts = { transparent_bg = true }, lazy = true },
}
