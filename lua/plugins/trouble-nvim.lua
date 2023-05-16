return {
    -- 这个插件可以让你更方便地查看 NeoVim 中的错误和警告信息。它提供了一个可视化的界面，让你更容易地查看和定位错误。
    {
        "folke/trouble.nvim",
        lazy=true,
        cmd = { "TroubleToggle", "Trouble" },
        opts = { use_diagnostic_signs = true },
        
    },
    
}
