return {

    -- tokyonight
    {
        "folke/tokyonight.nvim",
        opts = { style = "night" },
        priority = 1000,
        config=function()
            require("tokyonight").setup(
                {
                    -- transparent=true,
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
    
}
