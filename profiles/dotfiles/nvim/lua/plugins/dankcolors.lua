return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#141410',
				base01 = '#141410',
				base02 = '#5c6370',
				base03 = '#5c6370',
				base04 = '#abb2bf',
				base05 = '#ffffff',
				base06 = '#ffffff',
				base07 = '#ffffff',
				base08 = '#e05f86',
				base09 = '#e05f86',
				base0A = '#d3d9a2',
				base0B = '#a3e086',
				base0C = '#727e45',
				base0D = '#d3d9a2',
				base0E = '#827b39',
				base0F = '#827b39',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#5c6370',
				fg = '#ffffff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#d3d9a2',
				fg = '#141410',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#5c6370' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#727e45', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#827b39',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#d3d9a2',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#d3d9a2',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#727e45',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#a3e086',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#abb2bf' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#abb2bf' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#5c6370',
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
