extends MenuBar


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_file_id_pressed(id):
	if id == 0:
		$NewDocumentDialog.visible = true
	pass # Replace with function body.


func _on_new_document_dialog_close_requested():
	$NewDocumentDialog.visible = false
