return {
  -- 1. Gruvbox (Versi Lua Modern)
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
        transparent_mode = true,
        palette_overrides = { dark0_hard = "#1d2021" },
      })
    end,
  },

  -- 2. Gruvbox Material (Alternatif Retrobox Terbaik)
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

  -- 3. Everforest (Warm & Earthy)
  {
    "neanias/everforest-nvim",
    name = "everforest",
    priority = 1000,
    config = function()
      require("everforest").setup({
        background = "hard",
        ui_contrast = "high",
        transparent_background = true,
      })
    end,
  },

  -- 4. Catppuccin (Mocha)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
      })
    end,
  },

  -- 5. Nord
  { "shaunsingh/nord.nvim" },

  -- 6. Kanagawa (Dragon variant)
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup({
        theme = "dragon",
        transparent = true,
        background = { dark = "dragon" },
      })
    end,
  },

  -- 7. Rose Pine
  { "rose-pine/neovim", name = "rose-pine" },

  -- 8. OneDark
  {
    "navarasu/onedark.nvim",
    opts = { transparent = true },
  },

  -- 9. TokyoNight (Fallback)
  {
    "folke/tokyonight.nvim",
    opts = { transparent = true },
  },

  -- 10. Nightfox
  { "EdenEast/nightfox.nvim" },

  -- 11. Cyberdream
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
  },

  -- 12. Melange (Warm)
  { "savq/melange-nvim" },

  -- 13. Github Theme
  { "projekt0n/github-nvim-theme" },

  -- 14. Oxocarbon
  { "nyoom-engineering/oxocarbon.nvim" },

  -- 15. Dracula
  {
    "Mofiqul/dracula.nvim",
    opts = { transparent_bg = true },
  },
}
