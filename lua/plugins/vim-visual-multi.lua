return
{

    --多光标
    {
        "mg979/vim-visual-multi",
        config = function()
            vim.g.VM_set_default_mappings = 0 -- 关闭默认映射
            vim.g.VM_theme = 'ocean'
            vim.g.VM_highlight_matches = 'underline'
            vim.g.VM_maps = {
                ['Find Under'] = '<A-d>',
                ['Find Subword Under'] = '<A-d>',
                ['Select All'] = '<C-d>',
                ['Select h'] = '<C-Left>',
                ['Select l'] = '<C-Right>',
                ['Add Cursor Up'] = '<C-Up>',
                ['Add Cursor Down'] = '<C-Down>',
                ['Add Cursor At Pos'] = '<C-x>',
                ['Add Cursor At Word'] = '<C-w>',
                ['Move Left'] = '<C-S-Left>',
                ['Move Right'] = '<C-S-Right>',
                ['Remove Region'] = 'q',
                ['Increase'] = '+',
                ['Decrease'] = '_',
                ["Undo"] = 'u',
                ["Redo"] = '<C-r>',
            }
        end,
    },

}
