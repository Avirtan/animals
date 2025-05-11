components {
  id: "map"
  component: "/assets/tile_maps/map.tilemap"
}
components {
  id: "map_controller"
  component: "/src/scripts/controllers/level/map_controller.script"
  properties {
    id: "url_map"
    value: "#map"
    type: PROPERTY_TYPE_URL
  }
  properties {
    id: "url_factory"
    value: "#factory"
    type: PROPERTY_TYPE_URL
  }
}
embedded_components {
  id: "factory"
  type: "factory"
  data: "prototype: \"/resources/go/debug/astar/dot.go\"\n"
  ""
}
embedded_components {
  id: "collisionobject"
  type: "collisionobject"
  data: "collision_shape: \"/assets/tile_maps/map.tilemap\"\n"
  "type: COLLISION_OBJECT_TYPE_STATIC\n"
  "mass: 0.0\n"
  "friction: 0.1\n"
  "restitution: 0.5\n"
  "group: \"map\"\n"
  "mask: \"player\"\n"
  "mask: \"bullet\"\n"
  ""
}
