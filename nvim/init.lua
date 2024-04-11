--------------------------------------------------------------------------------
--                          _       _ __    __                                --
--                         (_)___  (_) /_  / /_  ______ _                     --
--                        / / __ \/ / __/ / / / / / __ `/                     --
--                       / / / / / / /__ / / /_/ / /_/ /                      --
--                      /_/_/ /_/_/\__(_)_/\__,_/\__,_/                       --
--                                                                            --
--------------------------------------------------------------------------------

require "core.settings"
require "core.keymaps"
require "core.autocmds"
require "core.commands"
require "core.lib"
require "core.lazy"

-- Optionally load local config if exists
pcall(require, "core.local")
