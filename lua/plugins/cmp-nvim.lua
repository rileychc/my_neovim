return {
  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
      local cmp = require("cmp")
      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<A-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<A-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<A-b>"] = cmp.mapping.scroll_docs(-4),
          ["<A-f>"] = cmp.mapping.scroll_docs(4),
          ["<A-Space>"] = cmp.mapping.complete(),
          ["<A-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = function(_, item)
            local icons = require("config").icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "LspCodeLens",
          },
        },
      }

      -- 我修改的tab补全
      -- local has_words_before = function()
      --   unpack = unpack or table.unpack
      --   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      --   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      -- end

      -- local luasnip = require("luasnip")
      -- local cmp = require("cmp")

      -- cmp.setup({

      --     -- completion = {   -开启很难受
      --     --   completeopt = "menu,menuone,noinsert",
      --     -- },
      --     snippet = {
      --       expand = function(args)
      --         require("luasnip").lsp_expand(args.body)
      --       end,
      --     },

      --   -- ... Your other configuration ...

      --   mapping = {

      --     -- ... Your other mappings ...

      --     ["<Tab>"] = cmp.mapping(function(fallback)
      --       if cmp.visible() then
      --         cmp.select_next_item()
      --       -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
      --       -- they way you will only jump inside the snippet region
      --       elseif luasnip.expand_or_jumpable() then
      --         luasnip.expand_or_jump()
      --       elseif has_words_before() then
      --         cmp.complete()
      --       else
      --         fallback()
      --       end
      --     end, { "i", "s" }),

      --     ["<S-Tab>"] = cmp.mapping(function(fallback)
      --       if cmp.visible() then
      --         cmp.select_prev_item()
      --       elseif luasnip.jumpable(-1) then
      --         luasnip.jump(-1)
      --       else
      --         fallback()
      --       end
      --     end, { "i", "s" }),

      --     -- ... Your other mappings ...
      --     ["<CR>"] = cmp.mapping({
      --       i = function(fallback)
      --         if cmp.visible() and cmp.get_active_entry() then
      --           cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
      --         else
      --           fallback()
      --         end
      --       end,
      --       s = cmp.mapping.confirm({ select = true }),
      --       c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
      --     }),

      --   },

      --   sources = cmp.config.sources({
      --     { name = "nvim_lsp" },
      --     { name = "luasnip" },
      --     { name = "buffer" },
      --     { name = "path" },
      --   }),
      --   formatting = {
      --     format = function(_, item)
      --       local icons = require("config").icons.kinds
      --       if icons[item.kind] then
      --         item.kind = icons[item.kind] .. item.kind
      --       end
      --       return item
      --     end,
      --   },
      --   experimental = {
      --     ghost_text = {
      --       hl_group = "LspCodeLens",
      --     },
      --   },
      -- })--到此结束
    end,
  },
}
