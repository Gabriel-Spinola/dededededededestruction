// https://www.raylib.com/examples/core/loader.html?name=core_3d_camera_first_person
package main

import "game"
import rl "vendor:raylib"

main :: proc() {
  game.init()

	for !rl.WindowShouldClose() {
		game.update()		
		game.draw()
	}

	rl.CloseWindow()
}
