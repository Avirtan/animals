local M = {
}

local state = {

}

function M.draw_cone(shooter_pos, direction, spread_angle, distance)
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

return M
