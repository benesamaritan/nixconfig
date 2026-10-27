return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,

    opts = {
      flavour = "mocha",
      transparent_background = true,
      term_colors = true,

      integrations = {
        mason = true,
        treesitter = true,
        telescope = true,
        lualine = true,
        cmp = true,
        gitsigns = true,
        notify = true,
        mini = true,
        noice = true,
        which_key = true,
        dashboard = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
      },

      highlight_overrides = {
        mocha = function(c)
          return {
            -- UI
            CursorLineNr = { fg = c.pink, bold = true },
            LineNr = { fg = c.overlay1 },
            Search = { bg = c.pink, fg = c.base },
            IncSearch = { bg = c.pink, fg = c.base },
            Visual = { bg = "none", fg = c.pink, bold = true },

            -- Telescope (pink outline, transparent)
            TelescopeBorder = { fg = c.pink },
            TelescopePromptBorder = { fg = c.pink },
            TelescopeResultsBorder = { fg = c.pink },
            TelescopePreviewBorder = { fg = c.pink },
            TelescopeSelection = { fg = c.text, bg = "none", bold = true },
            TelescopeMatching = { fg = c.pink, bold = true },

            -- Treesitter semantic colors
            ["@keyword"] = { fg = c.pink },
            ["@keyword.function"] = { fg = c.pink },
            ["@function"] = { fg = c.teal },
            ["@function.call"] = { fg = c.teal },
            ["@constant"] = { fg = c.maroon },
            ["@constant.builtin"] = { fg = c.maroon },
            ["@number"] = { fg = c.yellow },
            ["@float"] = { fg = c.yellow },
            ["@string"] = { fg = c.green },

            -------------------------------------------------------------------------
            -- EXTENDED PINK UI PACK
            -------------------------------------------------------------------------

            -- FLOATS
            NormalFloat = { bg = "none" },
            FloatBorder = { fg = c.pink, bg = "none" },
            FloatTitle = { fg = c.pink, bold = true },

            -- POPUPS / MENUS
            Pmenu = { bg = "none" },
            PmenuSel = { bg = "none", fg = c.pink, bold = true },
            PmenuThumb = { bg = c.pink },

            -- CMP COMPLETION (full pink)
            CmpItemAbbr = { fg = c.text },
            CmpItemAbbrMatch = { fg = c.pink, bold = true },
            CmpItemAbbrMatchFuzzy = { fg = c.pink, bold = true },
            CmpItemKind = { fg = c.mauve },
            CmpItemMenu = { fg = c.overlay2 },
            CmpBorder = { fg = c.pink },

            -- NOICE / NOTIFY / SNACKS
            NoiceCmdlinePopupBorder = { fg = c.pink },
            NoiceCmdlineIcon = { fg = c.pink },
            NoiceCmdlinePopupBorderSearch = { fg = c.pink },

            NotifyINFOBorder = { fg = c.pink },
            NotifyWARNBorder = { fg = c.maroon },
            NotifyERRORBorder = { fg = c.red },
            NotifyDEBUGBorder = { fg = c.overlay2 },
            NotifyTRACEBorder = { fg = c.pink },

            -- TELESCOPE (extra)
            TelescopeTitle = { fg = c.pink, bold = true },
            TelescopePromptTitle = { fg = c.pink, bold = true },
            TelescopePreviewTitle = { fg = c.pink, bold = true },

            -- GITSIGNS
            GitSignsAdd = { fg = c.teal },
            GitSignsChange = { fg = c.yellow },
            GitSignsDelete = { fg = c.maroon },

            -- INDENT BLANKLINE / IBL
            IblIndent = { fg = c.overlay0 },
            IblScope = { fg = c.pink },

            -- DIAGNOSTICS (pink-flavored)
            DiagnosticError = { fg = c.red },
            DiagnosticWarn = { fg = c.maroon },
            DiagnosticInfo = { fg = c.teal },
            DiagnosticHint = { fg = c.mauve },

            DiagnosticUnderlineError = { sp = c.red, undercurl = true },
            DiagnosticUnderlineWarn = { sp = c.maroon, undercurl = true },
            DiagnosticUnderlineInfo = { sp = c.teal, undercurl = true },
            DiagnosticUnderlineHint = { sp = c.mauve, undercurl = true },

            DiagnosticVirtualTextError = { fg = c.red, bg = "none" },
            DiagnosticVirtualTextWarn = { fg = c.maroon, bg = "none" },
            DiagnosticVirtualTextInfo = { fg = c.teal, bg = "none" },
            DiagnosticVirtualTextHint = { fg = c.mauve, bg = "none" },

            -- LSP INLAY HINTS
            LspInlayHint = { fg = c.overlay2, bg = "none", italic = true },

            -- SIGNCOLUMN + STATUSCOLUMN
            SignColumn = { bg = "none" },

            -- CURSOR UI
            CursorLine = { bg = c.surface0 },
            Cursor = { fg = c.base, bg = c.pink },
            iCursor = { fg = c.base, bg = c.pink },

            -- BORDERS (everywhere)
            WinSeparator = { fg = c.pink },

            -- LAZY UI
            LazyNormal = { bg = "none", fg = c.text },
            LazyBorder = { fg = c.pink },

            -- MINI PLUGINS
            MiniStatuslineModeNormal = { fg = c.base, bg = c.pink, bold = true },
            MiniStatuslineModeInsert = { fg = c.base, bg = c.teal, bold = true },
            MiniStatuslineModeVisual = { fg = c.base, bg = c.mauve, bold = true },
            MiniStatuslineModeReplace = { fg = c.base, bg = c.maroon, bold = true },
            MiniStatuslineModeCommand = { fg = c.base, bg = c.yellow, bold = true },

            MiniCursorword = { bg = c.surface1 },
            MiniCursorwordCurrent = { bg = c.surface1 },

            -- TREESITTER ADDITIONS
            ["@field"] = { fg = c.mauve },
            ["@property"] = { fg = c.pink },
            ["@variable"] = { fg = c.text },
            ["@variable.builtin"] = { fg = c.maroon },
          }
        end,
      },
    },

    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
