components {
  id: "base_enemy_character"
  component: "/src/scripts/controllers/characters/enemy/enemy_character_controller.script"
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
