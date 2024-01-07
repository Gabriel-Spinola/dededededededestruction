using MoonSharp.Interpreter;
using UnityEngine;

public class LuaIntegration : MonoBehaviour {
	void Start() {
		string script = @"    
		-- defines a factorial function
		function fact (n)
			if (n == 0) then
				return 1
			else
				return n*fact(n - 1)
			end
		end

		return fact(5)";

		DynValue res = Script.RunString(script);

		Debug.Log(res.Number);
	}
}
