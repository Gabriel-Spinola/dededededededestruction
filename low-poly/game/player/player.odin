package player

import rl "vendor:raylib"
import "core:fmt"
import "../lib"

transform: rl.Transform

@(private) PLAYER_COLOR :: rl.PURPLE

bounding_box: rl.BoundingBox

init :: proc(box: ^[20] lib.Object) {
  transform = rl.Transform {
    translation = rl.Vector3 { 0, 5, 0 },
    rotation = rl.Quaternion {},
    scale = rl.Vector3 { 1, 3, 1 },
  }

  bounding_box = rl.BoundingBox { 
    min = rl.Vector3 {
      transform.translation.x - transform.scale.x / 2,
      transform.translation.y - transform.scale.y / 2,
      transform.translation.z - transform.scale.z / 2,
    },
    max = rl.Vector3 {
      transform.translation.x + transform.scale.x / 2,
      transform.translation.y + transform.scale.y / 2,
      transform.translation.z + transform.scale.z / 2,
    },
  }

  for i in 0 ..< len(box) {
    fmt.println(box[i].bounding_box)
    fmt.println('\n')
  }

  fmt.println(bounding_box)
}

update :: proc(camera: ^rl.Camera, box: ^[20] lib.Object) {
  transform.translation = camera.target

  bounding_box = rl.BoundingBox { 
    min = rl.Vector3 {
      transform.translation.x - transform.scale.x / 2,
      transform.translation.y - transform.scale.y / 2,
      transform.translation.z - transform.scale.z / 2,
    },
    max = rl.Vector3 {
      transform.translation.x + transform.scale.x / 2,
      transform.translation.y + transform.scale.y / 2,
      transform.translation.z + transform.scale.z / 2,
    },
  }

  for i in 0 ..< 20 {
    if rl.CheckCollisionBoxes(bounding_box, box[i].bounding_box) {
      fmt.println("aaa")
    }
  }
}

draw :: proc(camera: ^rl.Camera) {
  rl.DrawCubeV(transform.translation, transform.scale, rl.PURPLE)
}