using System;
using System.Collections.Generic;
using MoonSharp.Interpreter;

public abstract class LuaModule {
  protected Dictionary<string, Delegate> _methods;

  public abstract void InstallBindings(Script script);
  public abstract void UninstallBindings(Script script);
}
