local CuttingScythes = require("CuttingScythes/CuttingScythes");

local function onWeaponSwingHitPoint(player, handWeapon)

    -- if not Scythe, quit
    if handWeapon and handWeapon:getType() ~= "HandScythe" then
        return
    end

    local didRemoveObject = false;

    CuttingScythes.ProcessLineOfSquares(player, function(object)
        if object:getProperties() and object:getProperties():Is(IsoFlagType.canBeRemoved) then
            didRemoveObject = true;
        end
    end);

    if didRemoveObject then
        -- play sound of grass being cut
        local sq = getCell():getGridSquare(player:getX(), player:getY(), player:getZ());
        sq:playSound("RemovePlant");
        addSound(player, player:getX(), player:getY(), player:getZ(), 10, 5);
    end
end

Events.OnWeaponSwingHitPoint.Add(onWeaponSwingHitPoint)
