local CuttingScythes = require("CuttingScythes/CuttingScythes");

local function onWeaponSwingHitPoint(player, handWeapon)

    -- if not Scythe, quit
    if handWeapon and handWeapon:getType() ~= "HandScythe" then
        return
    end

    local didRemoveObject = false;

    CuttingScythes.ProcessLineOfSquares(player, function(square, object)
        if object:getProperties() and object:getProperties():Is(IsoFlagType.canBeRemoved) then
            square:transmitRemoveItemFromSquare(object);
            didRemoveObject = true;
        end
    end);

    if didRemoveObject then
        -- reduce condition of scythe by its lower chance and player paintenance
        if ZombRand(handWeapon:getConditionLowerChance() * 2 + player:getMaintenanceMod() * 2) == 0 then
            handWeapon:setCondition(handWeapon:getCondition() - 1)
            ISWorldObjectContextMenu.checkWeapon(player);
        end

        -- xp for removing grass
        player:getXp():AddXP(Perks.Maintenance, 1);
    end
end

Events.OnWeaponSwingHitPoint.Add(onWeaponSwingHitPoint)
