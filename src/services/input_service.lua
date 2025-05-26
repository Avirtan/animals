local helper = require("druid.helper")

local M = {
    events = {
        key = hash("key"),
        touch = hash("touch"),
        multi_touch = hash("touch_multi"),
        mouse_move = hash("mouse_move")
    },
    input_binding = {
        up = hash("up"),
        down = hash("down"),
        left = hash("left"),
        right = hash("right"),
        touch = hash("touch"),
        multi_touch = hash("touch_multi"),
        fire = hash("fire")
    },
    current_inputs = {
        move_input = vmath.vector3(0, 0, 0),
        touch_input = vmath.vector3(0, 0, 0)
    },
    is_multitouch = helper.is_multitouch_supported(),
    multitouch_data = {
        touch_id_use = {}
    }
}

local state = {
    listeners = {},
    data_events = {
        key_data = {
            action_id = "",
            pressed = false,
            released = false,
            repeated = false
        },
        touch_data = {
            action_id = "",
            x = 0,
            y = 0,
            pressed = false,
            touch = {}
        }
    },

}

function M.addListener(event_id, component_url)
    if not state.listeners[event_id] then
        state.listeners[event_id] = {}
    end
    state.listeners[event_id][component_url] = component_url
end

function M.removeListener(event_id, component_url)
    if state.listeners[event_id] then
        state.listeners[event_id][component_url] = nil
    end
end

function M.dispatch(event_id, message)
    if state.listeners[event_id] then
        for _, url in pairs(state.listeners[event_id]) do
            msg.post(url, event_id, message)
        end
    end
end

--- @param action on_input.action
function M.handle_input(action_id, action)
    if not action_id then
        state.data_events.touch_data.x = action.x;
        state.data_events.touch_data.y = action.y;
        M.dispatch(M.events.mouse_move, state.data_events.touch_data)
        return
    end
    if action_id == M.input_binding.touch and not M.is_multitouch then
        state.data_events.touch_data.action_id = action_id
        state.data_events.touch_data.pressed = action.pressed;
        state.data_events.touch_data.x = action.x;
        state.data_events.touch_data.y = action.y;
        M.dispatch(M.events.touch, state.data_events.touch_data)
    elseif action_id == M.input_binding.multi_touch and M.is_multitouch then
        state.data_events.touch_data.action_id = action_id
        state.data_events.touch_data.pressed = action.pressed;
        state.data_events.touch_data.x = action.x;
        state.data_events.touch_data.y = action.y;
        state.data_events.touch_data.touch = action.touch
        M.dispatch(M.events.multi_touch, state.data_events.touch_data)
    elseif action_id ~= nil then
        state.data_events.key_data.action_id = action_id
        state.data_events.key_data.pressed = action.pressed;
        state.data_events.key_data.released = action.released;
        state.data_events.key_data.repeated = action.repeated;
        M.dispatch(M.events.key, state.data_events.key_data)
        return
    end
end

function M.is_move_input(message)
    return message.action_id == M.input_binding.up or message.action_id == M.input_binding.down or
        message.action_id == M.input_binding.right or message.action_id == M.input_binding.left
end

function M.set_input_move_key(message)
    local input = M.current_inputs.move_input

    if message.action_id == M.input_binding.up and input.y ~= -1 then
        input.y = message.released and 0 or 1
    elseif message.action_id == M.input_binding.down and input.y ~= 1 then
        input.y = message.released and 0 or -1
    end

    if message.action_id == M.input_binding.right and input.x ~= -1 then
        input.x = message.released and 0 or 1
    elseif message.action_id == M.input_binding.left and input.x ~= 1 then
        input.x = message.released and 0 or -1
    end
end

function M.set_input_move_joystick(x, y)
    local input = M.current_inputs.move_input
    input.x = x
    input.y = y
end

function M.set_input_touch(message)
    M.current_inputs.touch_input.x = message.x
    M.current_inputs.touch_input.y = message.y
end

return M
