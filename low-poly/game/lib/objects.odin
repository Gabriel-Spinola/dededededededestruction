package lib

import rl "vendor:raylib"

Object :: struct {
	transform: rl.Transform,
	bounding_box: rl.BoundingBox,
	color: rl.Color,
}

VEC3_FORWARD :: rl.Vector3 { 0, 0, 1 }
VEC3_RIGHT :: rl.Vector3 { 1, 0, 0 }
VEC3_UP :: rl.Vector3 { 0, 1, 0 }
