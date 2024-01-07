using System;
using MoonSharp.Interpreter;

public class GlobalModule : ILuaModule
{
    public void InstallBindings(Script script) {
        script.Globals["Debug"] = (Action<string>) UnityEngine.Debug.Log;
        script.Globals["DebugError"] = (Action<string>) UnityEngine.Debug.LogError;
        script.Globals["DebugWarning"] = (Action<string>) UnityEngine.Debug.LogWarning;
    }

    public void UninstallBindings(Script script) => throw new NotImplementedException();
}
