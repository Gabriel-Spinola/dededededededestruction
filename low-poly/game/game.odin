package game

import rl "vendor:raylib"
import "core:fmt"
import "lib"

import "player"

// https://gist.github.com/jakubtomsu/9cae5298f86d2b9d2aed48641a1a3dbd

// Constants
WINDOW_TITLE :: "FPS"
FRAME_RATE :: 60

SCREEN_WIDTH :: 800
SCREEN_HEIGHT :: 450

MAX_COLUMNS :: 20

// Variable Definitions
@(private) camera: rl.Camera
@(private) camera_mode: rl.CameraMode

@(private) columns: [MAX_COLUMNS] lib.Object

// Default Functions
init :: proc() {
  rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, WINDOW_TITLE)

	rl.SetTargetFPS(FRAME_RATE)
	rl.HideCursor()

	camera = init_camera()
	camera_mode = rl.CameraMode.THIRD_PERSON

	init_env()
} 

update :: proc() {
  rl.UpdateCamera(&camera, camera_mode)

	for i in 0 ..< MAX_COLUMNS {
		columns[i].bounding_box = rl.BoundingBox {
			min = rl.Vector3 {
				columns[i].transform.translation.x - columns[i].transform.scale.x / 2,
				columns[i].transform.translation.y - columns[i].transform.scale.y / 2,
				columns[i].transform.translation.z - columns[i].transform.scale.z / 2,
			},
			max = rl.Vector3 {
				columns[i].transform.translation.x + columns[i].transform.scale.x / 2,
				columns[i].transform.translation.y + columns[i].transform.scale.y / 2,
				columns[i].transform.translation.z + columns[i].transform.scale.z / 2,
			},
		}
	}

  player.update(&camera, &columns)
}

draw :: proc() {
  rl.BeginDrawing()
    rl.ClearBackground(rl.RAYWHITE)

    rl.BeginMode3D(camera)
      draw_env(&columns)

      player.draw(&camera)
    rl.EndMode3D()

    rl.DrawFPS(10, 10)
  rl.EndDrawing()
}

// Functions
@(private)
init_camera :: proc() -> rl.Camera {
  return rl.Camera {
    position = rl.Vector3 { 0, 3, 4 },
    target = player.transform.translation,
    up = rl.Vector3 { 0, 1, 0 },
    fovy = 60,
    projection = rl.CameraProjection.PERSPECTIVE,
  }
}

@(private)
init_env :: proc() {
  for i in 0 ..< MAX_COLUMNS {
		columns[i].transform.scale = rl.Vector3 { 2, cast(f32) rl.GetRandomValue(1, 12), 2 }

		columns[i].transform.translation = rl.Vector3 {
			cast(f32) rl.GetRandomValue(-15, 15),
			columns[i].transform.scale.y / 2.0,
			cast(f32) rl.GetRandomValue(-15, 15)
		}

		columns[i].color = rl.Color { cast(u8) rl.GetRandomValue(20, 255), cast(u8) rl.GetRandomValue(10, 55), 30, 255 }
	}
}

@(private)
draw_env :: proc(columns: ^[MAX_COLUMNS] lib.Object) {
	rl.DrawPlane(rl.Vector3{0, 0, 0}, rl.Vector2{32, 32}, rl.LIGHTGRAY) // Draw ground

	rl.DrawCube(rl.Vector3 { -16, 2, 0 }, 1, 5, 32, rl.BLUE);     // Draw a blue wall
	rl.DrawCube(rl.Vector3 { 16, 2, 0 }, 1, 5, 32, rl.LIME);      // Draw a green wall
	rl.DrawCube(rl.Vector3 { 0, 2, 16 }, 32, 5, 1, rl.GOLD);      // Draw a yellow wall

	for i in 0 ..< MAX_COLUMNS {
		rl.DrawCubeV(columns[i].transform.translation, columns[i].transform.scale, columns[i].color)
		rl.DrawCubeV(columns[i].bounding_box.max - columns[i].bounding_box.min, columns[i].transform.scale, columns[i].color)
	}
}