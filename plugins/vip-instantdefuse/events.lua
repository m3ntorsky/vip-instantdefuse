local Bomb = {
    isPlanted = false,
    plantedTime = nil,
    Vector = nil
}

local Threat = {
    he = 0,
    molotov = 0,
    inferno = {}
}

AddEventHandler("OnBombPlanted", function(event)
    Bomb.time = GetTime()
    Bomb.isPlanted = true
    Bomb.vector = CBaseEntity(GetPlantedBomb():ToPtr()).CBodyComponent.SceneNode.AbsOrigin
    return EventResult.Continue
end)

AddEventHandler("OnBombDefused", function()
    Bomb = {
        isPlanted = false,
        time = nil,
        vector = nil
    }
    Threat = {
        he = 0,
        molotov = 0,
        inferno = {}
    }
    return EventResult.Continue
end)

AddEventHandler("OnGrenadeThrown", function (event)
    local playerid = event:GetInt("userid")
    local player = GetPlayer(playerid)
    if not player or player:IsFakeClient() then return EventResult.Continue end

    local weapon =  event:GetString("weapon")

    if weapon == "smokegrenade" or weapon == "flashbang" or weapon == "decoy" then
         return EventResult.Continue
    end

    if weapon == "hegrenade" then
        Threat.he = Threat.he + 1
    end

    if weapon == "incgrenade" or weapon == "molotov" then
        Threat.molotov = Threat.molotov + 1
    end
    
end)

AddEventHandler("OnInfernoStartburn", function (event)

    if not Bomb.isPlanted then
         return EventResult.Continue
    end

    local infernoVector = Vector( event:GetInt("x"), event:GetInt("y"), event:GetInt("z"))
    local distance = GetDistanceBeetwenVectors(infernoVector, Bomb.vector)

    if distance > 250 then
        return EventResult.Continue
     end

    Threat.inferno[event:GetInt("entityid")] = true

    return EventResult.Continue
end)

AddEventHandler("OnInfernoExtinguish", function (event)
    Threat.inferno[event:GetInt("entityid")] = false
    return EventResult.Continue
end)

AddEventHandler("OnPostInfernoExpire", function (event)
    Threat.inferno[event:GetInt("entityid")] = false
    return EventResult.Continue
end)

AddEventHandler("OnHegrenadeDetonate", function (event)
    if Threat.he > 0 then Threat.he = Threat.he - 1 end
    return EventResult.Continue
end)

AddEventHandler("OnMolotovDetonate", function (event)
    if Threat.molotov > 0 then Threat.molotov = Threat.molotov - 1 end
    return EventResult.Continue
end)

AddEventHandler("OnBombBegindefuse", function (event)
    local playerid = event:GetInt("userid")
    if not config:Fetch("vip-instantdefuse.without_kit") and not event:GetBool("haskit") then
        return EventResult.Continue
    end
    if not exports["vipcore"]:IsFeatureEnabled(playerid,"instant-defuse") then
        return EventResult.Continue
    end
    
    local player = GetPlayer(playerid)
    if not player or player:IsFakeClient() then --- Safety check?
        return EventResult.Continue
    end
    

    if config:Fetch("vip-instantdefuse.he_threat_check") and Threat.he > 0 then
        player:SendMsg(MessageType.Chat, config:Fetch("vip-instantdefuse.prefix").. " " .. FetchTranslation("vip-instantdefuse.warning.hethreat"))
        return EventResult.Continue
    end
    
    if config:Fetch("vip-instantdefuse.molotov_threat_check") and (Threat.molotov > 0 or #Threat.inferno > 0) then
        player:SendMsg(MessageType.Chat, config:Fetch("vip-instantdefuse.prefix").. " " .. FetchTranslation("vip-instantdefuse.warning.molotovthreat"))
        return EventResult.Continue
    end

    

    if config:Fetch("vip-instantdefuse.alive_terrorist_check") and GetAlivePlayerCountByTeam(Team.T) > 0 then
        return EventResult.Continue
    end

    local bomb = GetPlantedBomb()
    
    if not bomb or bomb.CannotBeDefused then return end --- Safety check?

    NextTick(function()
        bomb.DefuseCountDown = 0
        player:SendMsg(MessageType.Chat, config:Fetch("vip-instantdefuse.prefix").. " " .. FetchTranslation("vip-instantdefuse.info.success"))
    end)

    return EventResult.Continue
    
end)


