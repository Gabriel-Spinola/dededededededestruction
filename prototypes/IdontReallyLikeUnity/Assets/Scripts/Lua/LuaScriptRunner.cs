using System;
using System.Collections.Generic;
using System.IO;
using System.Threading;
using MoonSharp.Interpreter;

public class LuaScriptRunner {
  private readonly List<LuaModule> _luaModules;
  private readonly Script _script;
  private readonly string _scriptPath;

  private Thread _runThread;

  public LuaScriptRunner(string scriptPath) {
    _script = new();
    _luaModules = new();

    _scriptPath = scriptPath;

    if (!File.Exists(_scriptPath)) {
      throw new ArgumentException($"{_scriptPath} not found");
    }

    SetupGlobalModules();
  }

  public void Run() {
    _runThread?.Abort();

    _runThread = new Thread(() => {
      string code = File.ReadAllText(_scriptPath);

      try {
        _script.DoString(code);
      }
      catch (ScriptRuntimeException error) {
        UnityEngine.Debug.LogError(error.DecoratedMessage);
      }
    });

    _runThread.Start();
  }

  public void AddModule(LuaModule module) {
    _luaModules.Add(module);

    module.InstallBindings(_script);
  }

  public void RemoveModule(LuaModule module) {
    if (!_luaModules.Contains(module)) {
      throw new ArgumentException("Lua module not currently installed");
    }

    _luaModules.Remove(module);
  }

  public void SetupGlobalModules() {
    _script.Globals["Debug"] = (Action<string>) UnityEngine.Debug.Log;
  }
}
