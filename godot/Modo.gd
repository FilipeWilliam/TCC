extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_next_focus_entered():
	if !Input.is_mouse_button_pressed(1):
		$".".grab_focus()
		$next.emit_signal("button_down")


func _on_previous_focus_entered():
	if !Input.is_mouse_button_pressed(1):
		$".".grab_focus()
		$previous.emit_signal("button_down")


