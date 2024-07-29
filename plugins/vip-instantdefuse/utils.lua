function GetPlantedBomb()
    local bombManagers = FindEntitiesByClassname("planted_c4")
    if #bombManagers < 1 then return nil end
    return CPlantedC4(bombManagers[#bombManagers]:ToPtr())
end

function GetAlivePlayerCountByTeam(teamid)
    local playersAlive = 0
    local playerCap = playermanager:GetPlayerCap()
    
    for i = 0, playerCap - 1 do
        local player = GetPlayer(i)
        if player and not player:IsFakeClient() then
            local controller = player:CCSPlayerController()
            local entity = player:CBaseEntity()
            
            if controller:IsValid() and controller.PawnIsAlive and entity.TeamNum == teamid then
                playersAlive = playersAlive + 1
            end
        end
    end
    
    return playersAlive
end

function GetDistanceBeetwenVectors(vector1 --[[Vector]], vector2 --[[Vector]])
    local distanceX = vector2.x - vector1.x
    local distanceY = vector2.y - vector1.y
    local distanceZ = vector2.z - vector1.z
    
    local distance = math.sqrt(distanceX * distanceX + distanceY * distanceY + distanceZ * distanceZ)
    return distance
end