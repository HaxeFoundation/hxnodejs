package js.node.vm;

/**
    A class for running JavaScript scripts.
    Returned by `Vm.createScript`.
**/
extern class Script {
    /**
        Similar to `Vm.runInThisContext` but a method of a precompiled `Script` object.
        `runInThisContext` runs the code of script and returns the result.
        Running code does not have access to local scope, but does have access to the global object (v8: in actual context).
    **/
    function runInThisContext():Dynamic;

    /**
        Similar to `Vm.runInNewContext` a method of a precompiled `Script` object.
        `runInNewContext` runs the code of script with `sandbox` as the global object and returns the result.
        Running code does not have access to local scope.
        `sandbox` is optional.

        Note that running untrusted code is a tricky business requiring great care.
        To prevent accidental global variable leakage, `runInNewContext` is quite useful,
        but safely running untrusted code requires a separate process.
    **/
    function runInNewContext(?sandbox:{}):Dynamic;
}
