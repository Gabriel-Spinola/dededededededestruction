using System;
using System.Collections.Generic;
using MoonSharp.Interpreter;

public interface ILuaModule {
  public void InstallBindings(Script script);
  public void UninstallBindings(Script script);
}
