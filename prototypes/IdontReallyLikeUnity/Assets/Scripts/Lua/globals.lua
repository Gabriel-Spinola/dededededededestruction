--- @diagnostic disable: unused-local
--- # Definition file for global functions and variables from LuaModules API

--- @type fun(message: string)
Debug = function (message) end

--- @type fun(errorMessage: string)
DebugError = function (errorMessage) end

--- @type fun(warningMessage: string)
DebugWarning = function (warningMessage) end