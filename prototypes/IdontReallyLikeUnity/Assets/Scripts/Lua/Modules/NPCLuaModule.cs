using System.Collections;
using System.Collections.Generic;
using MoonSharp.Interpreter;
using UnityEngine;

// TODO: Adding multi threading capabilities
public class NPCLuaModule : LuaModule {
    private NPCController _bindingObject;

    public override void InstallBindings(Script script) {
        throw new System.NotImplementedException();
    }

    public override void UninstallBindings(Script script) {
        throw new System.NotImplementedException();
    }
}
