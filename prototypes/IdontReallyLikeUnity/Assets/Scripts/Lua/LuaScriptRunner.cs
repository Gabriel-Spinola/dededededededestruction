using System;
using System.Collections.Generic;
using System.IO;
using System.Threading;
using MoonSharp.Interpreter;

public class LuaScriptRunner {
  public Action Start { get; private set; }
  public Action Update { get; private set; }

  private readonly List<ILuaModule> _luaModules;
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

    AddModule(new GlobalModule());
  }

  public void Run() {
    _runThread?.Abort();

    _runThread = new Thread(() => {
      string code = File.ReadAllText(_scriptPath);

      try {
        var dynCode = _script.DoString(code);

        // TODO - Better Handling
        Start = () => dynCode.Table.Get("start").Function?.Call();
        Update = () => dynCode.Table.Get("update").Function?.Call();
      }
      catch (ScriptRuntimeException error) {
        UnityEngine.Debug.LogError(error.DecoratedMessage);
      }
    });

    _runThread.Start();
  }

  public void AddModule(ILuaModule module) {
    _luaModules.Add(module);

    module.InstallBindings(_script);
  }

  public void RemoveModule(ILuaModule module) {
    if (!_luaModules.Contains(module)) {
      throw new ArgumentException("Lua module not currently installed");
    }

    _luaModules.Remove(module);
  }
}
