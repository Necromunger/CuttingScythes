require 'ISBaseObject';

---@class CuttingScythes
local CuttingScythes = ISBaseObject:derive("CuttingScythes");

---@param player IsoPlayer
---@param player function
function CuttingScythes.ProcessLineOfSquares(player, callback)
    local lastAngle = player:getLastAngle();
    local squares = ArrayList.new();

    squares:add(getCell():getGridSquare(player:getX(), player:getY(), player:getZ()));
    squares:add(getCell():getGridSquare(player:getX() + lastAngle:getX(), player:getY() + lastAngle:getY(), player:getZ()));

    for i = 0, squares:size() - 1 do
        local square = squares:get(i);
        local objects = square:getObjects();
        for j = 0, objects:size() - 1 do
            callback(square, objects:get(j));
        end
    end
end

return CuttingScythes;
