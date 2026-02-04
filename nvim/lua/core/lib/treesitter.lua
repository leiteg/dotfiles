local M = {}

M.has_parent_node = function(node_type)
    local node = vim.treesitter.get_node(nil)

    if not node then
        return false
    end

    local current = node

    while current do
        if current:type() == node_type then
            return true
        end
        current = current:parent()
    end

    return false
end

M.get_parent_node = function(node_type)
    local node = vim.treesitter.get_node(nil)

    if node == nil then
        return nil
    end

    local current = node

    while current do
        if current:type() == node_type then
            return current
        end
        current = current:parent()
    end

    return nil
end

M.get_node_text = function(node)
    return vim.treesitter.get_node_text(node, 0)
end

return M
