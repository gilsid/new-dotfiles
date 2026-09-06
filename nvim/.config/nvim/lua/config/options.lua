-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.shiftwidth = 4 -- Indent width (>> and <<)
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

local status, theme = pcall(require, "config.theme_cache")
local default_theme = "tokyonight"

-- Global for LazyVim
if status and type(theme) == "string" then
  vim.g.lazyvim_colorscheme = theme
else
  vim.g.lazyvim_colorscheme = default_theme
end

-- Swap colorscheme with fallback
local function try_colorscheme(name)
  local ok = pcall(vim.cmd, "colorscheme " .. name)
  if not ok and name ~= default_theme then
    pcall(vim.cmd, "colorscheme " .. default_theme)
  end
end

-- Apply the saved theme on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if status and theme then
      -- Defer one tick so plugins finish loading
      vim.schedule(function()
        try_colorscheme(theme)
      end)
    end
  end,
})
