extends Control

var popup_active = false

var quiz_title_active = true

var animation_speed = 0.05

onready var screen_size = OS.window_size

var resizer = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	print(OS.window_size)
	resize()

func alternativas_orientation(screen_size):
	if screen_size.x >= screen_size.y:
		$Alternativas/HRight.visible = true
		$Alternativas/HLeft/a.grab_focus()
		$Alternativas/HLeft.visible = true
		$Alternativas/V.visible = false
	else:
		$Alternativas/HRight.visible = false
		$Alternativas/HLeft.visible = false
		$Alternativas/V.visible = true
		$Alternativas/V/a.grab_focus()

func positions_setter():
	
	$MargemPopup/TextEditLogin.margin_left = 67
	$MargemPopup/TextEditLogin.margin_right = 332
	$MargemPopup/TextEditLogin.margin_top = 157
	$MargemPopup/TextEditLogin.margin_bottom = 164
	
	$MargemPopup/TextEditPassWord.margin_left = 67
	$MargemPopup/TextEditPassWord.margin_right = 332
	$MargemPopup/TextEditPassWord.margin_top = 247
	$MargemPopup/TextEditPassWord.margin_bottom = 284
	
	$MargemPopup/Entrar.rect_position = Vector2(160, 330)
	
	$MargemPopup/FecharTop.rect_position = Vector2(329.371, 50.96)
	$MargemPopup/FecharBottom.rect_position = Vector2(250, 310)
	
	$MargemPopup/Options.rect_position = Vector2(150, 220)
	$MargemPopup/fast_travel.rect_position = Vector2(110, 140)
	$MargemPopup/Retomar.rect_position = Vector2(150, 55)
	$MargemPopup/Sair.rect_position = Vector2(100, 300)
	
	$MargemPopup/RichTextLabel.margin_left = 24
	$MargemPopup/RichTextLabel.margin_top = 24
	$MargemPopup/RichTextLabel.margin_right = 376
	$MargemPopup/RichTextLabel.margin_bottom = 376

func resize():
	print(screen_size)
	resizer = ((screen_size.x + screen_size.y) * 0.5) * 0.0015
	print(resizer)
	$MargemPopup.rect_scale = Vector2(resizer, resizer)
	$Alternativas/HLeft.rect_scale = Vector2(resizer, resizer)
	$Alternativas/HRight.rect_scale = Vector2(resizer, resizer)
	$Alternativas/V.rect_scale = Vector2(resizer, resizer)
	if $".".name == "ground":
		$Char.scale = Vector3(resizer*0.15,resizer*0.15,resizer*0.15)
		#$AnimatedSprite3D.scale = Vector3(resizer*0.6,resizer*0.6,resizer*0.6)
	alternativas_orientation(screen_size)
	
	positions_setter()

func play_dissolve_show(node):
	if node != "MargemPopup" and node != "Alternativas":
		if $AnimationPlayer.has_animation(node + "_show") and !get_node("./MargemPopup/"+node).is_visible():
			$AnimationPlayer.queue(node + "_show")
		else:
			print("Animação show não encontrada em "+ node)
	else:
		if $AnimationPlayer.has_animation(node + "_show"):
			$AnimationPlayer.queue(node + "_show")
		else:
			print("Animação show não encontrada em "+ node)

func play_dissolve_hide(node):
	if node != "MargemPopup" and node != "Alternativas":
		if $AnimationPlayer.has_animation(node + "_hide") and get_node("./MargemPopup/"+node).is_visible():
			$AnimationPlayer.queue(node + "_hide")
		else:
			print("Animação hide não encontrada em "+ node)
	else:
		if $AnimationPlayer.has_animation(node + "_show"):
			$AnimationPlayer.queue(node + "_hide")
		else:
			print("Animação hide não encontrada em "+ node)


func _process(delta):
	
	if screen_size != OS.window_size:
		screen_size = OS.window_size
		resize()
	if $MargemPopup/FecharTop.rect_position != Vector2(329.371, 50.96):
		positions_setter()


func _on_Timer_timeout():
	positions_setter()
