components {
  id: "player_charactor_controller"
  component: "/src/scripts/character/controllers/player_charactor_controller.script"
  properties {
    id: "url_sprite"
    value: "#sprite_character"
    type: PROPERTY_TYPE_URL
  }
}
embedded_components {
  id: "sprite_character"
  type: "sprite"
  data: "default_animation: \"idle\"\n"
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
