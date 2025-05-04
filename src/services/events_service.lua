local M = {
    character_events = {
        disable         = hash("disable_character"),
        enable          = hash("enable_character"),
        send_path       = hash("send_path_event"),
        change_dir_move = hash("change_dir_move"),
        set_target      = hash("set_target_event"),
        set_model       = hash("set_model_controller")
    },
    animation_events = {
        change_animation_event = hash("change_animation_move"),
        set_sprite = hash("set_sprite_event")
    },
    router_events = {
        start_load_location = hash("start_load_location"),
        proxy_loaded = hash("proxy_loaded")
    },
    camera = {
        set_target = hash("set_target_camera")
    }
}



return M
