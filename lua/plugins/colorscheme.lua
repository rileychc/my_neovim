return {

    -- tokyonight
    {
        "folke/tokyonight.nvim",
        lazy = true,
        opts = { style = "moon" },
        priority = 1000,
        config=function()
            require("tokyonight").setup(
                {
                    transparent=true,
                    -- styles={sidebars="normal",
                    -- floats="normal"},
                    -- on_colors = function(colors)
                        -- colors.hint = colors.orange
                        -- colors.error = "#ff0000"
                    --   end
--  day_brightness=1,
                }
            )
        end,
    },

    -- -- catppuccin
    -- {
    --     "catppuccin/nvim",
    --     name = "catppuccin",
    -- },
    -- { "ellisonleao/gruvbox.nvim" },
    {
        "olimorris/onedarkpro.nvim",
      },

}
