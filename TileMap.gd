@tool
extends TileMap

signal size_changed(value:Vector2)

@export var size:Vector2i = Vector2i(20,20):
	set(value):
		size = value
		half_size = value / 2
		queue_redraw()
		if not Engine.is_editor_hint():
			emit_signal("size_changed",actual_size)
var half_size: Vector2i = size / 2

@export var show_grid:bool = true:
	set(value):
		show_grid = value
		queue_redraw()

var cell_size:Vector2

var actual_size:Vector2:
	get:
		return Vector2(size) * cell_size * scale

# Called when the node enters the scene tree for the first time.
func _ready():
	cell_size = tile_set.tile_size
	if not Engine.is_editor_hint():
		emit_signal("size_changed",actual_size)
	pass # Replace with function body.

var tmp_cnt:int = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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



func _on_tile_viewport_zoom_change(value, _zoomed_in):
	scale = Vector2.ONE * value
	emit_signal("size_changed",actual_size)
