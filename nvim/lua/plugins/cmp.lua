--[[
-- A completion plugin for neovim coded in Lua. 
--]]

local icons = {
    Text = "",
    Function = "󰊕",
    Method = "󰡱",
    Constructor = "󰎔",
    Field = "",
    Variable = "󰫧",
    Constant = "",
    Class = "󰆧",
    Struct = "󰆼",
    Enum = "",
    Snippet = "",
    File = "󰈔",
    Folder = "󰉋",
    Reference = "",
    Color = "",
    Interface = "",
    Module = "󰆧",
    Property = "",
    Unit = "",
    Keyword = "",
    EnumMember = "",
    Event = "",
    Value = "V",
    Operator = "O",
    TypeParameter = "T",
}

local config = function()
    local cmp = require("cmp")

    vim.opt.completeopt = { "menu", "menuone", "noselect" }

    cmp.setup({
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        window = {
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'nvim_lua' },
            { name = 'crates' },
            { name = 'calc' },
            { name = 'buffer' },
            { name = 'path' },
        }),
        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
                vim_item.kind = string.format("%s ", icons[vim_item.kind])
                vim_item.menu = ({
                    nvim_lsp = "[LSP]",
                    luasnip = "[LuaSnip]",
                    buffer = "[Buffer]",
                    path = "[Path]",
                })[entry.source.name]
                return vim_item
            end,
        },
    })

    cmp.setup({
        enabled = function()
            return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "prompt"
                or require("cmp_dap").is_dap_buffer()
        end
    })

    cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
        sources = {
            { name = "dap" },
        },
    })
end

return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-calc",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "saadparwaiz1/cmp_luasnip",
        "rcarriga/cmp-dap",
        "micangl/cmp-vimtex",
    },
    config = config,
}
