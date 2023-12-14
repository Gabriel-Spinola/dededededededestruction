package player

import "core:fmt"
import "core:math/linalg"
import rl "vendor:raylib"

import "../lib"

SPEED :: 20

velocity: rl.Vector3
transform: rl.Transform

@(private)
PLAYER_COLOR :: rl.PURPLE

bounding_box: rl.BoundingBox

can_move_x: bool = true

init :: proc(box: ^[20]lib.Object) {
	transform = rl.Transform {
		translation = rl.Vector3{0, 5, 0},
		rotation = rl.Quaternion{},
		scale = rl.Vector3{1, 3, 1},
	}
}

update :: proc(camera: ^rl.Camera, box: ^[20]lib.Object, deltaTime: f32) {
	handle_input(deltaTime)

	for i in 0 ..< 20 {
		if rl.CheckCollisionBoxes(bounding_box, box[i].bounding_box) {
      adjustPlayerOnCollision(&bounding_box, &box[i].bounding_box)
		}
	}

	// Damping
	velocity *= 1.0 / (1.0 + deltaTime * 2)

	// Camera movement
	camera.position += velocity * deltaTime

	// Camera Position
	camera.target = camera.position + (lib.VEC3_FORWARD * 3 + lib.VEC3_UP * -1.5)

	// Assign camera calculations to tranform
	transform.translation = camera.target

	calculate_bounding_box()
}

draw :: proc(camera: ^rl.Camera) {
	rl.DrawCubeV(transform.translation, transform.scale, rl.PURPLE)
}

@(private)
handle_input :: proc(deltaTime: f32) {
	if rl.IsKeyDown(.W) do velocity += lib.VEC3_FORWARD * deltaTime * SPEED
	if rl.IsKeyDown(.S) do velocity -= lib.VEC3_FORWARD * deltaTime * SPEED

	if rl.IsKeyDown(.D) do velocity -= lib.VEC3_RIGHT * deltaTime * SPEED
	if rl.IsKeyDown(.A) do velocity += lib.VEC3_RIGHT * deltaTime * SPEED
}

@(private)
calculate_bounding_box :: proc() {
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
}

@(private)
adjustPlayerOnCollision :: proc(box1, box2: ^rl.BoundingBox) {
  if box1.max.x > box2.max.x do velocity.x = clamp(velocity.x, 0, SPEED)
  if box1.max.x < box2.max.x do velocity.x = clamp(velocity.x, -SPEED, 0)

	if box1.max.z > box2.max.z do velocity.z = clamp(velocity.z, 0, SPEED)
  if box1.max.z < box2.max.z do velocity.z = clamp(velocity.z, -SPEED, 0)
}