using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NPCController : MonoBehaviour {
    private LuaScriptRunner _luaScriptRunner;

    private void Awake() {
        _luaScriptRunner = new LuaScriptRunner("Assets/Scripts/Lua/NPC.lua");
        _luaScriptRunner.Run();
    }

    void Start() {
        _luaScriptRunner.Start();
    }

    void Update() {
        _luaScriptRunner.Update();
    }
}
