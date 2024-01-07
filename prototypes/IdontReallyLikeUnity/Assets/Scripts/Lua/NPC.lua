local npc = {}

local hello = "Hello, Lua!"

function npc:start()
  -- Debug(hello)
  -- DebugWarning "Warning from lua"
  -- DebugError "Error from lua"
end

function npc:update()
  -- Debug "Debuggin for every frame"
end

return npc