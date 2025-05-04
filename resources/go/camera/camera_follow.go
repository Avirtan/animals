components {
  id: "camera_follow"
  component: "/src/scripts/camera/camera_follow.script"
  properties {
    id: "url_camera"
    value: "#camera"
    type: PROPERTY_TYPE_URL
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
  "orthographic_zoom: 2.0\n"
  ""
}
