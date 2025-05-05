--- @class TargetPlayerComponent
--- @field model EnemyModel
--- @field player hash
--- @field unit_manager UnitManager
local target_player_component = {}

--- @param model EnemyModel
--- @param unit_manager UnitManager
function target_player_component.new(model, unit_manager)
    local self = setmetatable({}, { __index = target_player_component })
    self.model = model
    self.unit_manager = unit_manager
    self.player = unit_manager.get_player().model.controller_url
    return self
end

function target_player_component:destroy()
end

function target_player_component:update(dt)
    if self.player == nil or self.model.target == nil then
        self.player = self.unit_manager.get_player().model.controller_url
        self.model.target = self.player
    end
end

function target_player_component:on_message(message_id, message)
end

return target_player_component
