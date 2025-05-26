local log = require("log.log")
local base_button_widget = require("src.gui.base_widgets.button.base_button_widget")
local base_scroll_vertical_widget = require("src.gui.base_widgets.scroll.base_scroll_vertical_widget")
local world_ecs = require "src.ecs.world_ecs"
local character_tag_component = require "src.ecs.components.tags.character_tag_component"
local state_unit_component = require "src.ecs.components.units.state_unit_component"
local spawn_enemy_component = require "src.ecs.components.events.sapwn_units.spawn_enemy_component"
local units_service = require "src.services.units.units_service"
local move_component = require "src.ecs.components.move.move_component"

local weapons_service = require "src.services.weapon.weapons_service"
local game_gui_service = require "src.services.gui.game_gui_service"
local save_service = require "src.services.save_service"
local input_service = require "src.services.input_service"

---@class DebugPanel: druid.widget
local M = {
    open_text = "Открыть дебаг",
    close_text = "Закрыть дебаг",
    items_selected_weapon = {}
}

function M:init()
    self.root = self:get_node("root")
    self.btn_open_hide = self.druid:new_widget(base_button_widget, "btn_show_hide", "root")
    self.selector_weapon = self.druid:new_widget(base_scroll_vertical_widget, "scroll_select_weapon", "root")
    self.btn_add_hp_enemy = self.druid:new_widget(base_button_widget, "btn_add_hp_enemy_unit", "root")
    self.btn_enemy_unit = self.druid:new_widget(base_button_widget, "btn_add_unit", "root")
    self.btn_enable_enemy_move = self.druid:new_widget(base_button_widget, "btn_enable_move_enemy", "root")
    self.btn_save_game = self.druid:new_widget(base_button_widget, "btn_save_game", "root")
    self.btn_reset_save = self.druid:new_widget(base_button_widget, "btn_reset_save", "root")
    self.btn_enable_joystick = self.druid:new_widget(base_button_widget, "btn_enable_joystick", "root")

    self.btn_open_hide.button.on_click:subscribe(self.open_debug, self)
    self.btn_open_hide:set_text(self.open_text)

    self.btn_add_hp_enemy.button.on_click:subscribe(self.add_hp_enemy, self)
    self.btn_add_hp_enemy:set_text("<size=2>добавить хр врагам</size>")
    self.btn_enemy_unit.button.on_click:subscribe(self.add_enemy, self)
    self.btn_enemy_unit:set_text("<size=2>добавить врага</size>")
    self.btn_enable_enemy_move.button.on_click:subscribe(self.enable_move_enemy, self)
    self.btn_enable_enemy_move:set_text("<size=2>Вкл движение врагам</size>")
    self.btn_save_game.button.on_click:subscribe(self.save_game, self)
    self.btn_save_game:set_text("<size=2>Сохранить игру</size>")
    self.btn_reset_save.button.on_click:subscribe(self.reset_save, self)
    self.btn_reset_save:set_text("<size=2>Сбросить сохранения</size>")
    self.btn_enable_joystick.button.on_click:subscribe(self.enable_joystick, self)
    self.btn_enable_joystick:set_text("<size=2>Включить джостик</size>")

    local all_weapons = weapons_service.get_weapons_config()
    local data_select = {}
    for _, value in pairs(all_weapons) do
        table.insert(data_select, {
            text = string.format("<size=2>%s</size>", value.name),
            data = {
                current = self,
                id = value.id
            }
        })
    end
    self.selector_weapon:set_select_data(data_select)
    self.selector_weapon.on_click_item:subscribe(self.select_weapon, self)
end

function M:select_weapon(data)
    weapons_service.open_weapon(data.id)
    local game_gui = game_gui_service.get_game_screen()
    game_gui.weapon_panel:reset()
    -- log:info("message", game_gui.weapon_panel)
end

function M:open_debug()
    local is_enable = gui.is_enabled(self.root, false)
    if is_enable then
        self.btn_open_hide:set_text(self.open_text)
    else
        self.btn_open_hide:set_text(self.close_text)
    end
    gui.set_enabled(self.root, not is_enable)
end

function M:add_hp_enemy()
    local entites = world_ecs.select_component(world_ecs.world_id.Main, character_tag_component.tag_enemy_name,
        state_unit_component.name)
    for _, entity in ipairs(entites) do
        --- @type StateUnitComponent
        local component_state_unit = world_ecs.get_component(world_ecs.world_id.Main, entity, state_unit_component.name)
        component_state_unit.health = component_state_unit.health + 100
    end
end

function M:enable_move_enemy()
    local entites = world_ecs.select_component(world_ecs.world_id.Main, character_tag_component.tag_enemy_name,
        move_component.name)
    for _, entity in ipairs(entites) do
        --- @type MoveComponent
        local component_move = world_ecs.get_component(world_ecs.world_id.Main, entity, move_component.name)
        component_move.speed = 40
    end
end

function M:add_enemy()
    local entity_spawn_enemy = world_ecs.create_entity(world_ecs.world_id.Main)
    local c1 = spawn_enemy_component.new(vmath.vector3(150, 40, 0), units_service.units_key.solder)
    world_ecs.add_component(world_ecs.world_id.Main, entity_spawn_enemy, c1)
end

function M:save_game()
    save_service.save()
end

function M:reset_save()
    save_service.reset_save()
end

function M:enable_joystick()
    input_service.is_multitouch = true
    game_gui_service.get_game_screen().aim_joystick_panel:enable()
    game_gui_service.get_game_screen().move_joystick_panel:enable()
end

function M:unload()
    self.btn_open_hide.button.on_click:unsubscribe(self.open_debug, self)
end

return M
