@tool
extends TileMap

@export var size:Vector2i = Vector2i(20,20):
	set(value):
		size = value
		half_size = value / 2
		queue_redraw()
var half_size: Vector2i = size / 2

@export var show_grid:bool = true:
	set(value):
		show_grid = value
		queue_redraw()

# Called when the node enters the scene tree for the first time.
func _ready():
	rendering_quadrant_size = 1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var used_cells = get_used_cells(0)
	for used_cell in used_cells:
		if not cell_is_within_bounds(used_cell) and not Engine.is_editor_hint():
			erase_cell(0,used_cell)

func _draw():
	if show_grid:
		draw_grid_lines()

func draw_grid_lines():
	for y in range(-half_size.y,half_size.y + 1):
		draw_line(Vector2(-half_size.x * tile_set.tile_size.x, y * tile_set.tile_size.y), Vector2(half_size.x * tile_set.tile_size.x, y * tile_set.tile_size.y), Color(1.0,0.0,0.0))
		pass
	for x in range(-half_size.x,half_size.x + 1):
		draw_line(Vector2(x * tile_set.tile_size.x, -half_size.y * tile_set.tile_size.y),Vector2(x * tile_set.tile_size.x, half_size.y * tile_set.tile_size.y),Color(1.0,0.0,0.0))
		pass


func cell_is_within_bounds(cell:Vector2i) -> bool:
	if (cell.x < half_size.x and cell.x >= -half_size.x) and (cell.y < half_size.y and cell.y >= -half_size.y):
		return true
	return false
