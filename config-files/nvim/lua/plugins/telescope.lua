return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      opts.defaults = opts.defaults or {}

      -- remove LazyVim border settings
      opts.defaults.borderchars = nil

      -- keep layout but allow Catppuccin to recolor
      opts.defaults.layout_config = opts.defaults.layout_config or {}
      opts.defaults.layout_config.prompt_position = "top"

      return opts
    end,
  },
}
