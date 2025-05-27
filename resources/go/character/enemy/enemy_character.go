components {
  id: "unit_controller"
  component: "/src/scripts/controllers/units/unit_controller.script"
  properties {
    id: "url_health"
    value: "#health"
    type: PROPERTY_TYPE_URL
  }
  properties {
    id: "url_sprite"
    value: "#sprite"
    type: PROPERTY_TYPE_URL
  }
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"infantry_left\"\n"
  "material: \"/resources/materials/sprite/sprite_character.material\"\n"
  "attributes {\n"
  "  name: \"colored_percent\"\n"
  "  double_values {\n"
  "    v: -8.0\n"
  "  }\n"
  "}\n"
  "attributes {\n"
  "  name: \"tint\"\n"
  "  double_values {\n"
  "    v: 0.6\n"
  "    v: 0.0\n"
  "    v: 0.0\n"
  "    v: 1.0\n"
  "  }\n"
  "}\n"
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
  "group: \"enemy\"\n"
  "mask: \"bullet\"\n"
  "mask: \"aim\"\n"
  "embedded_collision_shape {\n"
  "  shapes {\n"
  "    shape_type: TYPE_SPHERE\n"
  "    position {\n"
  "    }\n"
  "    rotation {\n"
  "    }\n"
  "    index: 0\n"
  "    count: 1\n"
  "  }\n"
  "  data: 11.0\n"
  "}\n"
  ""
}
embedded_components {
  id: "health"
  type: "label"
  data: "size {\n"
  "  x: 50.0\n"
  "  y: 20.0\n"
  "}\n"
  "text: \"health\"\n"
  "font: \"/builtins/fonts/default.font\"\n"
  "material: \"/builtins/fonts/label-df.material\"\n"
  ""
  position {
    y: 17.0
  }
  scale {
    x: 0.5
    y: 0.5
  }
}
