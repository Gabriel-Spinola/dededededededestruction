package game

import rl "vendor:raylib"

WINDOW_TITLE :: "FPS"
FRAME_RATE :: 60

SCREEN_WIDTH :: 800
SCREEN_HEIGHT :: 450

MAX_COLUMNS :: 20

Column :: struct {
	position: rl.Vector3,
	height: f32,
	color: rl.Color,
}

camera: rl.Camera
camera_mode: rl.CameraMode
columns: [MAX_COLUMNS] Column

init :: proc() {
  rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, WINDOW_TITLE)

	rl.SetTargetFPS(FRAME_RATE)
	rl.HideCursor()

	camera = init_camera()
	camera_mode = rl.CameraMode.FIRST_PERSON

	for i in 0..<MAX_COLUMNS {
		columns[i].height = cast(f32) rl.GetRandomValue(1, 12)

		columns[i].position = rl.Vector3 {
			cast(f32) rl.GetRandomValue(-15, 15),
			columns[i].height / 2.0,
			cast(f32) rl.GetRandomValue(-15, 15)
		}

		columns[i].color = rl.Color { cast(u8) rl.GetRandomValue(20, 255), cast(u8) rl.GetRandomValue(10, 55), 30, 255 }
	}
} 

update :: proc() {
  rl.UpdateCamera(&camera, camera_mode)
}

draw :: proc() {
  rl.BeginDrawing()
    rl.ClearBackground(rl.RAYWHITE)

    rl.BeginMode3D(camera)
      draw_env(&columns)

      rl.DrawText("Congrats! You created your first window!", 190, 200, 20, rl.LIGHTGRAY) 
    rl.EndMode3D()
  rl.EndDrawing()
}

init_camera :: proc() -> rl.Camera {
	camera: rl.Camera

	camera.position = rl.Vector3 {0, 2, 4}
	camera.target = rl.Vector3 {0, 2, 0}
	camera.up = rl.Vector3 {0, 1, 0}
	camera.fovy = 60
	camera.projection = rl.CameraProjection.PERSPECTIVE
	
	return camera
}

draw_env :: proc(columns: ^[MAX_COLUMNS] Column) {
	rl.DrawPlane(rl.Vector3{0, 0, 0}, rl.Vector2{32, 32}, rl.LIGHTGRAY) // Draw ground

	rl.DrawCube(rl.Vector3{ -16, 2, 0 }, 1, 5, 32, rl.BLUE);     // Draw a blue wall
	rl.DrawCube(rl.Vector3{ 16, 2, 0 }, 1, 5, 32, rl.LIME);      // Draw a green wall
	rl.DrawCube(rl.Vector3{ 0, 2, 16 }, 32, 5, 1, rl.GOLD);      // Draw a yellow wall

	for i in 0..<MAX_COLUMNS {
		rl.DrawCube(columns[i].position, 2, columns[i].height, 2, columns[i].color)
		rl.DrawCubeWires(columns[i].position, 2, columns[i].height, 2, rl.MAROON)
	}
}