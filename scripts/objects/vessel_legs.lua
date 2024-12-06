local vessel_legs, super = Class(Object)

function vessel_legs:init(vessel, data)
    super:init(self)
    self.vessel = vessel

    self.legs_sprite = Sprite("vii/head/"..data.head.."/walk")
    self.legs_sprite:setColor(data.hair_color)
    self:addChild(self.legs_sprite)
     
    self.legs_path = "vii/legs/"..data.legs.."/"

    self.offsets = {
        ["walk/down"] = {3, 30},
        ["walk/left"] = {2, 29},
        ["walk/right"] = {3, 29},
        ["walk/up"] = {3, 30}
    }
end

function vessel_legs:update_part()
    local spr = self.vessel.sprite_options[1]
    local walk = self.vessel.sprite_options[3]
    local legs = self.legs_sprite

    local frame = tonumber(spr:match("_(%d+)")) 
    local name = spr:match("^(.*)_")

    if legs[name] then
        if legs[name] == 1 then
            legs:setSprite(self.legs_path .. name)
        else
            local number = (frame - 1) % legs[name] + 1 

            legs:setSprite(self.legs_path .. name .. "_" .. number)
        end
    else
        local frames = Assets.getFrames(self.legs_path .. name)
        if frames then
            legs[name] = #frames
        else
            legs[name] = 1
        end
    end

    local offset = self.offsets[name] or {0, 0}
    legs.x, legs.y = offset[1], offset[2]
    
end

return vessel_legs