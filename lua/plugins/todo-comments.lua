return {
    -- 跳到 //FIX:  or  Note: 等注释
    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = { "BufReadPost", "BufNewFile" },
        config = true,
    },
}
