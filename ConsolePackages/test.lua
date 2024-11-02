return {
    func = function(arg1, arg2, arg3, arg4, ...)
        --[[
        env:
        commands = {...}
        runCommand(commandname, {args}, truetext? (nil or "string"))
        addText(text, color?)
        TextLabel: template textlabel instance
        console: the console part
        clearoutput()
        threadinstances = {} -- instances/threads/signals to be cleaned up when command is stopped
        keybinds = {[key] = {func = function, ctrl = usesctrl : false ? true}}
        bindtokey(key, usesctrl, function)
        handleArgs(string) -- parses string into arguments table
        ]]
        return "pong"
    end,
    description = "test package",
    truetext = false
}