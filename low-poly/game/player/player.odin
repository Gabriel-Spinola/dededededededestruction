package player

import "core:fmt"
import "core:math/linalg"
import rl "vendor:raylib"

import "../lib"

MAX_SPEED :: 20

velocity: rl.Vector3
transform: rl.Transform
bounding_box: rl.BoundingBox

@(private)
PLAYER_COLOR :: rl.PURPLE

@(private) can_move_x: bool = true
@(private) collision_offset: f32 = .1

init :: proc() {
	transform = rl.Transform {
		translation = rl.Vector3{0, 5, 0},
		rotation = rl.Quaternion{},
		scale = rl.Vector3{1, 3, 1},
	}
}

update :: proc(camera: ^rl.Camera, boxes: ^[20] lib.Object, deltaTime: f32) {
	handle_input(deltaTime)

	for i in 0 ..< len(boxes) {
		if rl.CheckCollisionBoxes(bounding_box, boxes[i].bounding_box) {
      adjustPlayerOnCollision(&bounding_box, &boxes[i].bounding_box)
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
	if rl.IsKeyDown(.W) do velocity += lib.VEC3_FORWARD * deltaTime * MAX_SPEED
	if rl.IsKeyDown(.S) do velocity -= lib.VEC3_FORWARD * deltaTime * MAX_SPEED

	if rl.IsKeyDown(.D) do velocity -= lib.VEC3_RIGHT * deltaTime * MAX_SPEED
	if rl.IsKeyDown(.A) do velocity += lib.VEC3_RIGHT * deltaTime * MAX_SPEED
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

// TODO - better collision
@(private)
adjustPlayerOnCollision :: proc(box1, box2: ^rl.BoundingBox) {
  if box1.max.x > box2.max.x do velocity.x = clamp(velocity.x, collision_offset, MAX_SPEED)
  if box1.max.x < box2.max.x do velocity.x = clamp(velocity.x, -MAX_SPEED, -collision_offset)

	if box1.max.z > box2.max.z do velocity.z = clamp(velocity.z, collision_offset, MAX_SPEED)
  if box1.max.z < box2.max.z do velocity.z = clamp(velocity.z, -MAX_SPEED, -collision_offset)
}