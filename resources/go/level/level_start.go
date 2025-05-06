components {
  id: "level_start_controller"
  component: "/src/scripts/controllers/level/start/level_start_controller.script"
  properties {
    id: "player_factory"
    value: "#player_factory"
    type: PROPERTY_TYPE_URL
  }
  properties {
    id: "enemy_factory"
    value: "#enemy_factory"
    type: PROPERTY_TYPE_URL
  }
  properties {
    id: "bullet_factory"
    value: "#bullet_factory"
    type: PROPERTY_TYPE_URL
  }
  properties {
    id: "location_controller"
    value: "#location_start_controller"
    type: PROPERTY_TYPE_URL
  }
}
components {
  id: "location_start_controller"
  component: "/src/scripts/controllers/level/start/location_start_controller.script"
}
embedded_components {
  id: "player_factory"
  type: "collectionfactory"
  data: "prototype: \"/resources/collection/characters/player.collection\"\n"
  ""
}
embedded_components {
  id: "enemy_factory"
  type: "factory"
  data: "prototype: \"/resources/go/character/enemy/enemy_character.go\"\n"
  ""
}
embedded_components {
  id: "bullet_factory"
  type: "factory"
  data: "prototype: \"/resources/go/character/bullets/bullet.go\"\n"
  ""
}
