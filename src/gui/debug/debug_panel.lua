local log = require("log.log")
local base_button_widget = require("src.gui.base_widgets.button.base_button_widget")
local weapons_service = require "src.services.weapon.weapons_service"

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

    self.select_item_weapon = self.druid:new_widget(base_button_widget, "select_item_weapon", "root")

    self.scroll = self.druid:new_scroll("view_select_weapon", "content_select_weapon")

    self.grid = self.druid:new_grid("content_select_weapon", self.select_item_weapon:get_node("root"), 1)
    self.scroll:bind_grid(self.grid)
    self.scroll:set_horizontal_scroll(false)

    local all_weapons = weapons_service.get_all_weapons()
    for _, value in pairs(all_weapons) do
        local select_item_weapon = self.druid:new_widget(base_button_widget, "select_item_weapon", "root")
        gui.set_enabled(select_item_weapon:get_node("root"), true)
        self.grid:add(select_item_weapon:get_node("root"))
        select_item_weapon:set_text(value.name)
        select_item_weapon.button.on_click:subscribe(self.select_weapon, {
            current = self,
            id = value.id
        })
        table.insert(self.items_selected_weapon, select_item_weapon)
    end
end

function M:select_weapon()

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
