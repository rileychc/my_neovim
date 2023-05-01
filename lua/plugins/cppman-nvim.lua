
return
{

    {
        "madskjeldgaard/cppman.nvim",
        event = "VeryLazy",
        dependencies = {
            { 'MunifTanjim/nui.nvim' },
        },
        keys = {
             {  "<leader>cw", function()require("cppman").open_cppman_for(vim.fn.expand("<cword>"))end  ,desc="cur word help"}, 
             { "<leader>ch", "<cmd>CPPMan<CR>" ,desc="Find lib help"}, 
            },
        config = function()
        require("cppman").setup()
        end,
    }
}
