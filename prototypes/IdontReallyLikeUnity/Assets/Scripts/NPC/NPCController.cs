using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NPCController : MonoBehaviour {
    private LuaScriptRunner _luaScriptRunner;

    // Start is called before the first frame update
    void Start() {
        _luaScriptRunner = new LuaScriptRunner("Assets/Scripts/Lua/NPC.lua");
        _luaScriptRunner.Run();
        //_luaScriptRunner.AddModule(new NPCLuaModule());
    }

    void Update() {
        
    }
}
