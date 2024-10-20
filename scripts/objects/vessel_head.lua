local vessel_head, super = Class(Object)

function vessel_head:init(vessel, data)
    super:init(self)

    self.vessel = vessel

    self.outline = Sprite("vii/head/"..data.head.."/outline/walk")
    self.outline:setColor(data.hair_color)
    --self:addChild(self.outline)

    self.head_sprite = Sprite("vii/head/"..data.head.."/walk")
    self.head_sprite:setColor(data.skin_color)
    self:addChild(self.head_sprite)
     
    self.head_path = "vii/head/"..data.head.."/"

    self.offsets = {
        ["walk/down"] = {0, 0},
        ["walk/left"] = {-2, -1},
        ["walk/right"] = {2, -1},
        ["walk/up"] = {0, 0},
        ["battle/idle"] = {0, -2}
    }
end

function vessel_head:update_part()
    local spr = self.vessel.sprite_options[1]
    local walk = self.vessel.sprite_options[3]
    local head = self.head_sprite

    if walk == "walk" then
        local direction = spr:match("^(.*)_") -- Extract the direction part (e.g., "walk/up")
        local frame = tonumber(spr:match("_(%d+)")) -- Extract the frame number
    
        if frame then
            head:setSprite(self.head_path .. direction) -- Set sprite based on direction
            head.x, head.y = self.offsets[direction][1], 1 - (frame % 2) + self.offsets[direction][2]
        end
    else
        local name = spr:match("^(.*)_")
        local frame = tonumber(spr:match("_(%d+)")) -- Extract the frame number

        if head[name] then
            if head[name] == 1 then
                head:setSprite(self.head_path .. name)
            else
                local number = (frame - 1) % head[name] + 1 -- Loop back around if frame exceeds head[name]
                head:setSprite(self.head_path .. name .. "_" .. number)
            end
        else
            local frames = Assets.getFrames(self.head_path .. name)
            if frames then
                head[name] = #frames
            else
                head[name] = 1
            end
        end

        local offset = self.offsets[name] or {0, 0}
        head.x, head.y = offset[1], offset[2]
    end
    
end

return vessel_head