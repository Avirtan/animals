local screen_service       = require "src.services.screen_service"
local astar_service        = require "src.services.map.astar_service"
local components_service   = require "src.services.components_service"
local events_service       = require "src.services.events_service"

--- @class MoveAstarComponent
--- @field last_input vector3
--- @field animation_data vector3
--- @field input vector3
--- @field dir_move vector3
--- @field paths table
--- @field target_point vector3
--- @field model EnemyModel
local move_astar_component = {}

--- @param model EnemyModel
function move_astar_component.new(model)
    local self                = setmetatable({}, { __index = move_astar_component })
    self.dir                  = vmath.vector3(0, 0, 0)
    self.paths                = {}
    self.target_point         = vmath.vector3()
    self.animation_data       = {
        x = 0,
        y = 0
    }
    self.points               = {}
    self.time_dely_update     = 1
    self.model                = model
    self.last_position_target = vmath.vector3()
    return self
end

function move_astar_component:destroy()
end

--- @param model CharacterModel
--- @param model_1 EnemyModel
function move_astar_component:update(dt, model, model_1)
    if self.model.target == nil then
        return
    end
    if self.time_dely_update <= 0 then
        self:update_path()
        self.time_dely_update = 1
    end
    self.time_dely_update = self.time_dely_update - dt


    if #self.paths > 0 and self.target_point.x == 0 and self.target_point.y == 0 then
        self.target_point.x = self.paths[1]
        self.target_point.y = self.paths[2]
        self.model.base_model.dir_move = vmath.normalize(self.target_point -
            go.get_position(self.model.base_model.controller_url));
        self.animation_data.x = self.model.base_model.dir_move.x
        self.animation_data.y = self.model.base_model.dir_move.y
        -- self.model:on_message(components_service.name.sprite_animation,
        --     events_service.animation_events.change_animation_event,
        --     self.animation_data)
    end
    if self.target_point.x ~= 0 and self.target_point.y ~= 0 then
        local distance = vmath.length(go.get_position(self.model.base_model.controller_url) - self.target_point)
        if distance < 1 then
            self.target_point.x = 0
            self.target_point.y = 0
            self.model.base_model.dir_move.x = 0
            self.model.base_model.dir_move.y = 0
            table.remove(self.paths, 1)
            table.remove(self.paths, 1)
            if #self.paths == 0 then
                self.animation_data.x = 0
                self.animation_data.y = 0
                -- self.model:on_message(components_service.name.sprite_animation,
                --     events_service.animation_events.change_animation_event,
                --     self.animation_data)
            end
        end
    end
end

function move_astar_component:on_message(message_id, message)
end

function move_astar_component:update_path()
    local position_target = go.get_position(self.model.target)
    if self.last_position_target.x == position_target.x and self.last_position_target.y == position_target.y then
        print("цель не двигается")
        return
    end
    self.last_position_target = position_target
    local position = go.get_position(self.model.base_model.controller_url)
    local tileXStart, tileYStart = screen_service.world_to_tile(position.x, position.y)
    local tileXEnd, tileYEnd = screen_service.world_to_tile(position_target.x, position_target.y)
    local status, size, total_cost, path = astar.solve(tileXStart, tileYStart, tileXEnd, tileYEnd)
    if status == astar.SOLVED then
        for index, _ in ipairs(self.paths) do
            self.paths[index] = nil
        end
        local i = 1;
        for _, tile in ipairs(path) do
            local x, y        = screen_service.tile_to_world(tile.x, tile.y);
            self.paths[i]     = x
            self.paths[i + 1] = y
            i                 = i + 2;
        end
        astar_service.show_points_debug(self.model.base_model.controller_url, path)
    end
end

return move_astar_component
