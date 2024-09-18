--------------------------------------------------------------------------------
-- REQUIRES
--------------------------------------------------------------------------------

local utils = require("core.lib.sniputils")

--------------------------------------------------------------------------------
-- INITIALIZATION
--------------------------------------------------------------------------------

-- Utils
local snippet = utils.snippet

--------------------------------------------------------------------------------
-- SNIPPETS
--------------------------------------------------------------------------------

local snippets = {}

--------------------------------------------------------------------------------
-- AUTOSNIPPETS
--------------------------------------------------------------------------------

local autosnippets = {

    snippet(";info",    "Info Callout",    [[>> [!info] ]],    {}),
    snippet(";note",    "Note Callout",    [[>> [!note] ]],    {}),
    snippet(";summary", "Summary Callout", [[>> [!summary] ]], {}),
    snippet(";info",    "Info Callout",    [[>> [!info] ]],    {}),
    snippet(";todo",    "Todo Callout",    [[>> [!todo] ]],    {}),
    snippet(";tip",     "Tip Callout",     [[>> [!tip] ]],     {}),
    snippet(";done",    "Done Callout",    [[>> [!done] ]],    {}),
    snippet(";help",    "Help Callout",    [[>> [!help] ]],    {}),
    snippet(";warning", "Warning Callout", [[>> [!warning] ]], {}),
    snippet(";fail",    "Fail Callout",    [[>> [!fail] ]],    {}),
    snippet(";error",   "Error Callout",   [[>> [!error] ]],   {}),
    snippet(";bug",     "Bug Callout",     [[>> [!bug] ]],     {}),
    snippet(";example", "Example Callout", [[>> [!example] ]], {}),
    snippet(";quote",   "Quote Callout",   [[>> [!quote] ]],   {}),

}

--------------------------------------------------------------------------------
-- RETURN
--------------------------------------------------------------------------------

return snippets, autosnippets
