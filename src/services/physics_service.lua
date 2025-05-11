local events_service = require "src.services.events_service"

local M = {
}


function M.is_physic_message(message_id)
    return message_id == events_service.physics.collision_response or
        message_id == events_service.physics.contact_point_response or
        message_id == events_service.physics.trigger_response
end

return M
