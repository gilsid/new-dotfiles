return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#1e2030',
				base01 = '#1e2030',
				base02 = '#899094',
				base03 = '#899094',
				base04 = '#e1eaef',
				base05 = '#f8fdff',
				base06 = '#f8fdff',
				base07 = '#f8fdff',
				base08 = '#ff9fbe',
				base09 = '#ff9fbe',
				base0A = '#9adcfa',
				base0B = '#a5ffaf',
				base0C = '#cbeeff',
				base0D = '#9adcfa',
				base0E = '#aee5ff',
				base0F = '#aee5ff',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#899094',
				fg = '#f8fdff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#9adcfa',
				fg = '#1e2030',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#899094' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#cbeeff', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#aee5ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#9adcfa',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#9adcfa',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#cbeeff',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#a5ffaf',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#e1eaef' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#e1eaef' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#899094',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
