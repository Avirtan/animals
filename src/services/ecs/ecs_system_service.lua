local world_ecs = require "src.ecs.world_ecs"

local spawn_player_system = require "src.ecs.systems.events.spawn_player_system"
local move_input_system = require "src.ecs.systems.units.move_input_system"
local animation_unit_move_system = require "src.ecs.systems.animations.animation_unit_move_system"
local camera_follow_system = require "src.ecs.systems.camera.camera_follow_system"
local aim_moving_system = require "src.ecs.systems.aim.aim_moving_system"
local aim_scaling_system = require "src.ecs.systems.aim.aim_scaling_system"
local spawn_enemy_system = require "src.ecs.systems.events.spawn_enemy_system"
local move_astar_system = require "src.ecs.systems.units.move_astar_system"
local spawn_bullet_system = require "src.ecs.systems.events.spawn_bullet_system"
local move_bullet_system = require "src.ecs.systems.bullets.move_bullet_system"
local check_bullet_position = require "src.ecs.systems.bullets.check_bullet_position_system"
local reset_collision_system = require "src.ecs.systems.physics.reset_collision_system"
local bullet_check_collision = require "src.ecs.systems.bullets.bullet_check_collision_system"
local select_target_player_system = require "src.ecs.systems.targets.select_target_player_system"
local astar_calculate_path_system = require "src.ecs.systems.astar.astar_calculate_path_system"
local weapon_shoot_system = require "src.ecs.systems.weapon.weapon_shoot_system"
local change_weapon_system = require "src.ecs.systems.events.change_weapon_system"
local change_health_system = require "src.ecs.systems.events.change_health_system"


local M = {}

function M.init_main_systems(world_id)
    M.spawn_systems(world_id)
    M.move_systems(world_id)
    M.aim_systems(world_id)
    M.animation_systems(world_id)
    M.camera_systems(world_id)
    M.bullet_systems(world_id)
    M.select_target_systems(world_id)
    M.weapon_system(world_id)
    M.unit_state_system(world_id)
    --- это должно быть в конце
    M.reset_systems(world_id)
end

function M.spawn_systems(world_id)
    world_ecs.add_system(world_id, spawn_player_system)
    world_ecs.add_system(world_id, spawn_enemy_system)
    world_ecs.add_system(world_id, spawn_bullet_system)
end

function M.move_systems(world_id)
    world_ecs.add_system(world_id, astar_calculate_path_system)

    world_ecs.add_system(world_id, move_input_system)
    world_ecs.add_system(world_id, aim_moving_system)
    world_ecs.add_system(world_id, move_astar_system)
    world_ecs.add_system(world_id, move_bullet_system)
end

function M.animation_systems(world_id)
    world_ecs.add_system(world_id, animation_unit_move_system)
end

function M.aim_systems(world_id)
    world_ecs.add_system(world_id, aim_scaling_system)
end

function M.camera_systems(world_id)
    world_ecs.add_system(world_id, camera_follow_system)
end

function M.bullet_systems(world_id)
    world_ecs.add_system(world_id, check_bullet_position)
    world_ecs.add_system(world_id, bullet_check_collision)
end

function M.select_target_systems(world_id)
    world_ecs.add_system(world_id, select_target_player_system)
end

function M.reset_systems(world_id)
    world_ecs.add_system(world_id, reset_collision_system)
end

function M.weapon_system(world_id)
    world_ecs.add_system(world_id, weapon_shoot_system)
    world_ecs.add_system(world_id, change_weapon_system)
end

function M.unit_state_system(world_id)
    world_ecs.add_system(world_id, change_health_system)
end

return M
