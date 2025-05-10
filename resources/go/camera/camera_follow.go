components {
  id: "script"
  component: "/src/scripts/camera/camera_controller.script"
  properties {
    id: "url_camera"
    value: "#camera"
    type: PROPERTY_TYPE_URL
  }
  properties {
    id: "near_z"
    value: "0.1"
    type: PROPERTY_TYPE_NUMBER
  }
  properties {
    id: "far_z"
    value: "100.0"
    type: PROPERTY_TYPE_NUMBER
  }
  properties {
    id: "zoom"
    value: "2.0"
    type: PROPERTY_TYPE_NUMBER
  }
  properties {
    id: "follow_horizontal"
    value: "false"
    type: PROPERTY_TYPE_BOOLEAN
  }
  properties {
    id: "follow_vertical"
    value: "false"
    type: PROPERTY_TYPE_BOOLEAN
  }
}
embedded_components {
  id: "camera"
  type: "camera"
  data: "aspect_ratio: 1.0\n"
  "fov: 0.7854\n"
  "near_z: 0.1\n"
  "far_z: 1000.0\n"
  "orthographic_projection: 1\n"
  ""
}
