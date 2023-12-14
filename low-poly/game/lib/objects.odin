package lib

import rl "vendor:raylib"

Object :: struct {
	transform: rl.Transform,
	bounding_box: rl.BoundingBox,
	color: rl.Color,
}
