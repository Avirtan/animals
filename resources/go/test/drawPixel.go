components {
  id: "drawPixel"
  component: "/src/scripts/test/drawPixel.script"
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"keys\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/sprites/circle/circle.atlas\"\n"
  "}\n"
  ""
  position {
    z: 1.0
  }
  scale {
    x: 0.2
    y: 0.2
  }
}
