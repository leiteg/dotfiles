vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('LspConfig', {}),
    callback = function(event)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[event.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local map = function(mode, lhs, rhs, desc)
            local opts = { buffer = event.buf, desc = desc }
            vim.keymap.set(mode, lhs, rhs, opts)
        end

        local async_format = function()
            vim.lsp.buf.format({ async = true })
        end

        -- Use lsp-zero keymaps
        map('n', 'K', vim.lsp.buf.hover, 'Hover documentation')
        map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
        map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
        map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')
        map('n', 'go', vim.lsp.buf.type_definition, 'Go to type definition')
        map('n', 'gr', vim.lsp.buf.references, 'Go to reference')
        map('n', 'gs', vim.lsp.buf.signature_help, 'Show function signature')
        map('n', '<F2>', vim.lsp.buf.rename, 'Rename symbol')
        map('n', '<F3>', async_format, 'Format file')
        map('x', '<F3>', async_format, 'Format selection')
        map('n', '<F4>', vim.lsp.buf.code_action, 'Execute code action')

        if vim.lsp.buf.range_code_action then
            map('x', '<F4>', vim.lsp.buf.range_code_action, 'Execute code action')
        else
            map('x', '<F4>', vim.lsp.buf.code_action, 'Execute code action')
        end

        map('n', 'gl', vim.diagnostic.open_float, 'Show diagnostic')
        map('n', '[d', vim.diagnostic.goto_prev, 'Previous diagnostic')
        map('n', ']d', vim.diagnostic.goto_next, 'Next diagnostic')

        --[[
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
        --]]
    end,
})

return {
    "neovim/nvim-lspconfig",
}
