local input_service = require "src.services.input_service"
local screen_service = require "src.services.screen_service"

--- @class AimCircleComponent
--- @field url_aim hash
--- @field parent userdata
--- @field tmp_vector vector3
--- @field current_state_size boolean
local aim_circle_component = {}

function aim_circle_component.new(url_aim)
    local self = setmetatable({}, { __index = aim_circle_component })
    self.url_aim = url_aim
    self.parent = go.get_parent(self.url_aim)
    self.tmp_vector = vmath.vector3()
    self.current_state_size = false
    return self
end

function aim_circle_component:destroy()
end

--- @param unit CharacterModel
function aim_circle_component:update(dt, unit)
    if unit.is_moving and not self.current_state_size then
        go.set(self.url_aim, "scale.x", 1)
        go.set(self.url_aim, "scale.y", 1)
        self.current_state_size = true
    elseif not unit.is_moving and self.current_state_size then
        go.set(self.url_aim, "scale.x", 0.5)
        go.set(self.url_aim, "scale.y", 0.5)
        self.current_state_size = false
    end
end

--- @param unit CharacterModel
function aim_circle_component:on_message(message_id, message, unit)
    if input_service.events.mouse_move == message_id then
        local x, y = screen_service.screen_to_world(message.x, message.y)
        local position_player = go.get_position(self.parent)
        self.tmp_vector.x = x
        self.tmp_vector.y = y
        local local_position = self.tmp_vector - position_player
        self:draw_cone(position_player, local_position, 40, 100)

        local len = vmath.length_sqr(local_position)
        if len > 10000 then
            local_position = vmath.normalize(local_position) * 100
        end
        go.set_position(local_position, self.url_aim)
    end
end

function aim_circle_component:draw_cone(shooter_pos, direction, spread_angle, distance)
    -- Преобразуем угол разброса в радианы
    local half_angle_rad = math.rad(spread_angle) / 2
    local dir_normalized = vmath.normalize(direction)

    -- Получаем базовый угол направления
    local base_angle = math.atan2(dir_normalized.y, dir_normalized.x)

    -- Рассчитываем углы для границ конуса
    local angle1 = base_angle - half_angle_rad
    local angle2 = base_angle + half_angle_rad

    -- Рассчитываем конечные точки линий
    local end_point1 = vmath.vector3(
        shooter_pos.x + math.cos(angle1) * distance,
        shooter_pos.y + math.sin(angle1) * distance,
        0
    )

    local end_point2 = vmath.vector3(
        shooter_pos.x + math.cos(angle2) * distance,
        shooter_pos.y + math.sin(angle2) * distance,
        0
    )

    -- Рисуем линии (используя draw_line из Defold)
    msg.post("@render:", "draw_line", {
        start_point = shooter_pos,
        end_point = end_point1,
        color = vmath.vector4(1, 0, 0, 1) -- Красный цвет
    })

    msg.post("@render:", "draw_line", {
        start_point = shooter_pos,
        end_point = end_point2,
        color = vmath.vector4(1, 0, 0, 1) -- Красный цвет
    })

    -- Опционально: рисуем дугу между границами
    local segments = 10
    local prev_point = end_point1
    for i = 1, segments do
        local t = i / segments
        local angle = angle1 + (angle2 - angle1) * t
        local arc_point = vmath.vector3(
            shooter_pos.x + math.cos(angle) * distance,
            shooter_pos.y + math.sin(angle) * distance,
            0
        )

        msg.post("@render:", "draw_line", {
            start_point = prev_point,
            end_point = arc_point,
            color = vmath.vector4(0, 1, 0, 0.5) -- Зеленый цвет с прозрачностью
        })

        prev_point = arc_point
    end
end

return aim_circle_component
