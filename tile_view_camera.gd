extends Camera2D

@export var zoom_step:Vector2 = Vector2(0.1,0.1)
@export var zoom_min:Vector2 = Vector2(0.5,0.5)
@export var zoom_max:Vector2 = Vector2(5,5)
var mouse_position:Vector2
var rel_m_c:Vector2 #rename

@onready var sub_view_container:Control = $"../../"

# Called when the node enters the scene tree for the first time.
func _ready():
	#offset = -sub_view_container.size / 2
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("camera_mouse_drag"):
		Input.set_custom_mouse_cursor(preload("res://pan_cursor.png"))
		offset += rel_m_c / zoom
	if Input.is_action_just_released("camera_mouse_drag"):
		Input.set_custom_mouse_cursor(null)
	rel_m_c = Vector2.ZERO


func _input(event):
	var last_mouse_position = mouse_position
	if event is InputEventMouseMotion:
		var new_mouse_position = event.position
		if new_mouse_position != last_mouse_position:
			mouse_position = new_mouse_position
			rel_m_c = last_mouse_position - mouse_position
	
	if event.is_action("camera_zoom_in"):
		zoom_to_position(zoom + Vector2.ONE * .1, get_local_mouse_position() - (offset / zoom ))
	
		
	
	if event.is_action("camera_zoom_out"):
		zoom = (zoom - zoom_step).clamp(zoom_min,zoom_max)
	

func zoom_to_position(p_zoom:Vector2, pos:Vector2):
	print(zoom_step)
	var n_zoom = p_zoom.clamp(zoom_min,zoom_max)
	if (n_zoom == zoom):
		return
	var last_zoom = zoom
	zoom = n_zoom
	var offset_increment = pos / last_zoom - pos / zoom
	offset += offset_increment
	print(offset," : ",offset_increment)
	print("Z: ",zoom)
	#offset = (offset + pos) / last_zoom * zoom - pos;
	
	var closest_zoom_factor = zoom.round()
	print(closest_zoom_factor)
	if (zoom - closest_zoom_factor).is_equal_approx(Vector2.ZERO):
		zoom = zoom.round() #reduce float
		var offset_int = offset.floor()
		var offset_frac = offset - offset_int
		offset = offset_int + (offset_frac * closest_zoom_factor).round() / closest_zoom_factor
		print("finaloffset: ",offset)
