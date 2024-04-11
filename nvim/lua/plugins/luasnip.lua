--[[
-- Snippet Engine for Neovim written in Lua.
--]]
return {
    "L3MON4D3/LuaSnip",
    lazy = false,
    version = "v2.*",
    run = "make install_jsregexp",
    config = function()
        local ls = require("luasnip")
        local types = require("luasnip.util.types")

        -- CONFIG --------------------------------------------------------------

        ls.config.setup {
            history = true,
            update_events = "TextChanged,TextChangedI",
            enable_autosnippets = true,
            ext_opts = {
                [types.choiceNode] = {
                    active = {
                        virt_text = { { " 󰙁 Choose ", "DiagnosticVirtualTextHint" } },
                    },
                },
            },
        }

        -- LOAD LUA SNIPPETS ---------------------------------------------------

        require("luasnip.loaders.from_lua").lazy_load({
            paths = vim.fn.stdpath("config") .. "/snippets/"
        })

        -- KEYMAPS -------------------------------------------------------------

        vim.keymap.set({ "i", "s" }, "<c-j>", function()
            if ls.expand_or_jumpable() then
                ls.expand_or_jump()
            end
        end, { silent = true, desc = "Luasnip Expand" })

        vim.keymap.set({ "i", "s" }, "<c-k>", function()
            if ls.jumpable(-1) then
                ls.jump(-1)
            end
        end, { silent = true, desc = "Luasnip Jump Back" })

        vim.keymap.set({ "i", "s" }, "<c-l>", function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end, { silent = true, desc = "Luasnip Change Choice" })
    end
}
