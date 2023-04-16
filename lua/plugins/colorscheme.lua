return {

    -- tokyonight
    {
        "folke/tokyonight.nvim",
        lazy = true,
        opts = { style = "moon" },
        priority=1000,
    },

    -- catppuccin
    {
        "catppuccin/nvim",
        lazy = true,
        name = "catppuccin",
    },
    { "ellisonleao/gruvbox.nvim" },
    {
        "olimorris/onedarkpro.nvim",
        priority = 1000 -- Ensure it loads first
      },

}
