return {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      -- Colors
      local c = {
        base = "#1e1e2e",
        mantle = "#181825",
        crust = "#11111b",
        text = "#cdd6f4",
        surface0 = "#313244",
        surface1 = "#45475a",
        pink = "#f5c2e7",
        mauve = "#cba6f7",
        maroon = "#eba0ac",
        yellow = "#f9e2af",
        teal = "#94e2d5",
        red = "#f38ba8",
      }

      -- Pink bubbles theme
      local bubbles_pink = {
        normal = {
          a = { fg = c.crust, bg = c.pink, gui = "bold" },
          b = { fg = c.text, bg = c.surface0 },
          c = { fg = c.text, bg = c.mantle },
        },
        insert = { a = { fg = c.crust, bg = c.teal, gui = "bold" } },
        visual = { a = { fg = c.crust, bg = c.mauve, gui = "bold" } },
        replace = { a = { fg = c.crust, bg = c.red, gui = "bold" } },
        command = { a = { fg = c.crust, bg = c.yellow, gui = "bold" } },
        inactive = {
          a = { fg = c.surface1, bg = c.crust },
          b = { fg = c.surface1, bg = c.crust },
          c = { fg = c.surface1, bg = c.crust },
        },
      }

      -- Setup lualine
      require("lualine").setup({
        options = {
          theme = bubbles_pink,
          section_separators = { left = "", right = "" },
          component_separators = "",
          globalstatus = true,
        },
        sections = {
          lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
          lualine_b = { "branch", "diff" },
          lualine_c = { "filename" },
          lualine_x = { "diagnostics", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
        },
      })
    end,
  },
}
