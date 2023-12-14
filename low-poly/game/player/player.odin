package player

import rl "vendor:raylib"
import "core:fmt"
import "../lib"

transform: rl.Transform

@(private) PLAYER_COLOR :: rl.PURPLE

bounding_box: rl.BoundingBox

init :: proc() {
  transform = rl.Transform {
    translation = rl.Vector3 { 0, 5, 0 },
    rotation = rl.Quaternion {},
    scale = rl.Vector3 { 1, 3, 1 },
  }

  bounding_box = rl.BoundingBox { 
    min = rl.Vector3 {
      transform.translation.x - 1 / 2,
      transform.translation.y - 3 / 2,
      transform.translation.z - 1 / 2,
    },
    max = rl.Vector3 {
      transform.translation.x + 1 / 2,
      transform.translation.y + 3 / 2,
      transform.translation.z + 1 / 2,
    },
  }
}

update :: proc(camera: ^rl.Camera, box: ^[20] lib.Object) {
  transform.translation = camera.target

  for i in 0 ..< 20 {
    if rl.CheckCollisionBoxes(bounding_box, box[i].bounding_box) {
      fmt.println("aaa")
    }
  }
}

draw :: proc(camera: ^rl.Camera) {
  // fmt.println(transform)
  rl.DrawCubeV(transform.translation, {1, 3, 1}, rl.PURPLE)
}