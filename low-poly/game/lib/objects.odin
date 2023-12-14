package lib

import rl "vendor:raylib"

Object :: struct {
	transform: rl.Transform,
	color: rl.Color,
	bounding_box: rl.BoundingBox,
}
