using MoonSharp.Interpreter;

// TODO: Adding multi threading capabilities
public class NPCLuaModule : ILuaModule {
    private NPCController _bindingObject;

    public void InstallBindings(Script script) {
        throw new System.NotImplementedException();
    }

    public void UninstallBindings(Script script) {
        throw new System.NotImplementedException();
    }
}
