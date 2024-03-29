--------------------------------------------------------------------------------
--                          _       _ __    __                                --
--                         (_)___  (_) /_  / /_  ______ _                     --
--                        / / __ \/ / __/ / / / / / __ `/                     --
--                       / / / / / / /__ / / /_/ / /_/ /                      --
--                      /_/_/ /_/_/\__(_)_/\__,_/\__,_/                       --
--                                                                            --
--------------------------------------------------------------------------------

require "config.settings"
require "config.keymaps"
require "config.autocmds"
require "config.lazy"

-- Optionally load local config if exists
pcall(require, "config.local")
