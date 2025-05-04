components {
  id: "base_enemy_character"
  component: "/src/scripts/character/controllers/enemy/enemy_character_controller.script"
  properties {
    id: "url_astar_move"
    value: "#astar_move_enemy"
    type: PROPERTY_TYPE_URL
  }
}
components {
  id: "astar_move_enemy"
  component: "/src/scripts/character/components/move/astar_move_enemy.script"
  properties {
    id: "url_animation"
    value: "#sprite"
    type: PROPERTY_TYPE_URL
  }
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"tank\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/atlases/player.atlas\"\n"
  "}\n"
  ""
  position {
    z: 1.0
  }
}
