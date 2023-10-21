extends Node2D


var current_menu = "Login"
var current_mode = "Básico"
var modos_de_jogo = ["Básico", "Mão Única", "Baixa Visão", "Sem Visão"]


# Called when the node enters the scene tree for the first time.
func _ready():
	$ground/Mesh/AnimationPlayer.play("stand")
	call_popup()
	

func _process(delta):
	print(current_mode)

func call_popup():
	$ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/RichTextLabel.bbcode_text = "[center]Entre em sua conta para continuar:\n\nUsuário\n\n\nSenha"
	$ground/Camroot_MI/h/v/Camera/UI_MI.play_dissolve_show("MargemPopup")
	$ground/Camroot_MI/h/v/Camera/UI_MI.positions_setter()
	$ground/Camroot_MI/h/v/Camera/UI_MI.popup_active = true
	$ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/Options.visible = false
	$ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/Sair.visible = false
	$ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/MenuOptions.visible = false
	$ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/Entrar.visible = true
	$ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/TextEditLogin.visible = true
	$ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/TextEditPassWord.visible = true
	$ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup.modulate = Color(1,1,1,0.0)
	if current_mode == "Mão Única":
		$ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/TextEditLogin.grab_focus()

func call_popup_title():
	$ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/RichTextLabel.bbcode_text = "[center]\nBem Vindo(a)"
	$ground/Camroot_MI/h/v/Camera/UI_MI.play_dissolve_show("MargemPopup")
	$ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/Options.visible = true
	$ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/Sair.visible = true
	$ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/Entrar.visible = false
	$ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/TextEditLogin.visible = false
	$ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/TextEditPassWord.visible = false
	$ground/Camroot_MI/h/v/Camera/UI_MI.positions_setter()
	$ground/Camroot_MI/h/v/Camera/UI_MI.popup_active = true
	$ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup.modulate = Color(1,1,1,0.0)

func call_options_menu():
	current_menu = "options"
	$ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/MenuOptions.visible = true
	$ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/MenuOptions/Modo.grab_focus()


func close_to_esc_menu():
	$ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/MenuOptions.visible = false
	$ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/MenuFasTravel.visible = false
	if current_menu == "options":
		current_mode = modos_de_jogo[modos_de_jogo.find($ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/MenuOptions/RichTextLabel.bbcode_text.replace("[center]", ""),0)]
	current_menu = "esc_menu"
	if current_mode == "Mão Única":
		$ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/Retomar.grab_focus()

func next_mode():
	if current_mode == "Mão Única":
		$ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/MenuOptions/Modo.grab_focus()
	if $ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/MenuOptions/RichTextLabel.bbcode_text == "[center]"+modos_de_jogo[len(modos_de_jogo)-1]:
		print("[center]" + modos_de_jogo[0])
		$ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/MenuOptions/RichTextLabel.bbcode_text = "[center]" + modos_de_jogo[0]
	else: 
		print(modos_de_jogo.find($ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/MenuOptions/RichTextLabel.bbcode_text.replace("[center]", ""),0))
		$ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/MenuOptions/RichTextLabel.bbcode_text = "[center]" + modos_de_jogo[modos_de_jogo.find($ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/MenuOptions/RichTextLabel.bbcode_text.replace("[center]", ""),0)+1]

func previous_mode():
	if current_mode == "Mão Única":
		$ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/MenuOptions/Modo.grab_focus()
	if $ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/MenuOptions/RichTextLabel.bbcode_text == "[center]"+modos_de_jogo[0]:
		print("[center]" + modos_de_jogo[len(modos_de_jogo)-1])
		$ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/MenuOptions/RichTextLabel.bbcode_text = "[center]" + modos_de_jogo[len(modos_de_jogo)-1]
	else: 
		print(modos_de_jogo.find($ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/MenuOptions/RichTextLabel.bbcode_text.replace("[center]", ""),0))
		$ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/MenuOptions/RichTextLabel.bbcode_text = "[center]" + modos_de_jogo[modos_de_jogo.find($ground/Camroot_MI/h/v/Camera/UI_MI/MargemPopup/MenuOptions/RichTextLabel.bbcode_text.replace("[center]", ""),0)-1]


func _on_Entrar_button_down():
	call_popup_title()


func _on_Sair_button_down():
	call_popup()


func _on_Options_button_down():
	call_options_menu()



func _on_next_button_down():
	next_mode()


func _on_previous_button_down():
	previous_mode()


func _on_FecharBottom_button_down():
	close_to_esc_menu()
