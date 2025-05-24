local log = require("log.log")
local base_button_widget = require("src.gui.base_widgets.button.base_button_widget")
local base_scroll_vertical_widget = require("src.gui.base_widgets.scroll.base_scroll_vertical_widget")

local weapons_service = require "src.services.weapon.weapons_service"
local game_gui_service = require "src.services.gui.game_gui_service"

---@class DebugPanel: druid.widget
local M = {
    open_text = "Открыть дебаг",
    close_text = "Закрыть дебаг",
    items_selected_weapon = {}
}

function M:init()
    self.root = self:get_node("root")

    self.btn_open_hide = self.druid:new_widget(base_button_widget, "btn_show_hide", "root")
    self.btn_open_hide.button.on_click:subscribe(self.open_debug, self)
    self.btn_open_hide:set_text(self.open_text)
    self.selector_weapon = self.druid:new_widget(base_scroll_vertical_widget, "scroll_select_weapon", "root")

    local all_weapons = weapons_service.get_all_weapons()
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
    weapons_service.select_weapon(data.id)
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

function M:unload()
    self.btn_open_hide.button.on_click:unsubscribe(self.open_debug, self)
end

return M
