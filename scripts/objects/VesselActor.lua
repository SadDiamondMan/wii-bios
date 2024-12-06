local VesselActor, super = Class(ActorSprite)

function VesselActor:init(actor, data)
    super:init(self, actor)

    self.parts = {vessel_head(self, data), vessel_legs(self, data)}

    for _,v in pairs(self.parts) do
        v:setOrigin(0.5, 1)
        self:addChild(v)
        v:update_part()
    end

end

function VesselActor:draw()

    for _, v in pairs(self.parts) do
        v:update_part()
    end

    super:draw(self)
end

return VesselActor