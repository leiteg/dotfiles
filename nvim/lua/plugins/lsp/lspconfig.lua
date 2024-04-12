--[[
-- Quickstart configs for Nvim LSP.
--]]

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('LspConfig', {}),
    callback = function(event)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[event.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- :h lsp-inlay_hint
        vim.api.nvim_create_user_command("ToggleInlayHints", function()
            vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled(0))
        end, {})

        vim.api.nvim_create_user_command("LspWorkspaceList", function()
            vim.lsp.buf.list_workspace_folders()
        end, {})

        -- Wrapper for `vim.lsp.buf.format`
        local async_format = function()
            vim.lsp.buf.format({ async = true })
        end

        local keymaps = {
            { 'n', 'K',    vim.lsp.buf.hover,           'Hover documentation' },
            { 'n', 'gd',   vim.lsp.buf.definition,      'Go to definition' },
            { 'n', 'gD',   vim.lsp.buf.declaration,     'Go to declaration' },
            { 'n', 'gi',   vim.lsp.buf.implementation,  'Go to implementation' },
            { 'n', 'go',   vim.lsp.buf.type_definition, 'Go to type definition' },
            { 'n', 'gr',   vim.lsp.buf.references,      'Go to reference' },
            { 'n', 'gs',   vim.lsp.buf.signature_help,  'Show function signature' },
            { 'n', '<F2>', vim.lsp.buf.rename,          'Rename symbol' },
            { 'n', '<F3>', async_format,                'Format file' },
            { 'x', '<F3>', async_format,                'Format selection' },
            { 'n', '<F4>', vim.lsp.buf.code_action,     'Execute code action' },
            { 'n', 'gl',   vim.diagnostic.open_float,   'Show diagnostic' },
            { 'n', '[d',   vim.diagnostic.goto_prev,    'Previous diagnostic' },
            { 'n', ']d',   vim.diagnostic.goto_next,    'Next diagnostic' },
        }

        if vim.lsp.buf.range_code_action then
            table.insert(keymaps, { 'x', '<F4>', vim.lsp.buf.range_code_action, 'Execute code action' })
        else
            table.insert(keymaps, { 'x', '<F4>', vim.lsp.buf.code_action, 'Execute code action' })
        end

        for _, keymap in ipairs(keymaps) do
            local mode = keymap[1]
            local lhs = keymap[2]
            local rhs = keymap[3]
            local desc = keymap[4]

            vim.keymap.set(mode, lhs, rhs, { desc = desc, buffer = true })
        end
    end,
})

return {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
}
