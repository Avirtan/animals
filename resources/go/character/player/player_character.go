components {
  id: "unit_controller"
  component: "/src/scripts/controllers/units/unit_controller.script"
  properties {
    id: "url_sprite"
    value: "#sprite_character"
    type: PROPERTY_TYPE_URL
  }
}
embedded_components {
  id: "sprite_character"
  type: "sprite"
  data: "default_animation: \"solder_idle\"\n"
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
embedded_components {
  id: "collisionobject"
  type: "collisionobject"
  data: "type: COLLISION_OBJECT_TYPE_KINEMATIC\n"
  "mass: 0.0\n"
  "friction: 0.1\n"
  "restitution: 0.5\n"
  "group: \"player\"\n"
  "mask: \"map\"\n"
  "embedded_collision_shape {\n"
  "  shapes {\n"
  "    shape_type: TYPE_SPHERE\n"
  "    position {\n"
  "    }\n"
  "    rotation {\n"
  "    }\n"
  "    index: 0\n"
  "    count: 1\n"
  "    id: \"collision\"\n"
  "  }\n"
  "  data: 7.5\n"
  "}\n"
  "locked_rotation: true\n"
  ""
}
