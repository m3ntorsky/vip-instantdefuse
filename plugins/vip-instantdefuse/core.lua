
AddEventHandler("OnAllPluginsLoaded", function()
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:RegisterFeature("instantdefuse", "vip-instantdefuse.feature.title")
    end

    return EventResult.Continue
end)

function GetPluginAuthor()
    return "m3ntor"
end

function GetPluginVersion()
    return "v1.0.0"
end

function GetPluginName()
    return "VIP - Instant Defuse"
end

function GetPluginWebsite()
    return "https://github.com/m3ntorsky/vip-instantdefuse"
end