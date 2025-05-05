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
