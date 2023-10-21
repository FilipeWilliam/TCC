extends Spatial


var data_ilhas = {}
var start_timer = false
var data_ilhas_respostas = {}
var spawn_point = Vector3(0, 0, 0)
var modos_de_jogo = ["Básico", "Mão Única", "Baixa Visão", "Sem Visão"]
var ilhas_positions_dictionary = {"spawn_point":spawn_point}
var islands_list = []
var current_shown_island = ""
var b = true
var t = 0
var oceanY = 0
var current_focus_out = 0
var current_focus_node = ""
var current_island = ""
var current_menu = ""
var current_mode = "Básico"
var last_said = ""
var current_question

var path_data_ilhas = "res://Questions/Questions.json"
var path_data_ilhas_respostas = "res://Questions/Responses.json"
var island_scene = preload("res://Island.tscn")

# TO DO List:
# requisitar ilhas ativas e renderiza-las no mapa
# checar se alguma ilha renderizada já foi parcialmente concluída (salvo localmente) e sinaliza-la
# delimitar espaço navegável

func _ready():
	$WorldEnvironment.environment.background_sky.ground_bottom_color = $TilesRendered.get_child(0).mesh.material.get_shader_param('out_color')
	$WorldEnvironment.environment.background_sky.ground_horizon_color = $TilesRendered.get_child(0).mesh.material.get_shader_param('out_color')
	#$WorldEnvironment.environment.background_sky.sky_top_color = $MeshInstance.mesh.material.get_shader_param('out_color')
	$WorldEnvironment.environment.background_sky.sky_horizon_color = $TilesRendered.get_child(0).mesh.material.get_shader_param('out_color')
	tileRender()
	load_data()
	#print(data_ilhas)
	load_islands()
	$boat/Camroot/h/v/Camera/UI/MargemPopup/MenuOptions/RichTextLabel.bbcode_text = "[center]"+current_mode
	#print(data_ilhas_respostas)
	#save_data()
	#var timeDict = OS.get_datetime()
	#print(timeDict)
	#$TTS.speak("Olá Adriana tudo bem com você?")
	get_viewport().connect("gui_focus_changed", self, "_on_focus_changed")

func _on_focus_changed(control:Control) -> void:
	if control != null:
		current_focus_node = control.name
		

func reposition_random():
	
	var x_range = Vector2(-20*len(data_ilhas), 20*len(data_ilhas))
	var z_range = Vector2(-20*len(data_ilhas), 20*len(data_ilhas))

	var random_x = randi() % int(x_range[1]- x_range[0]) + 1 + x_range[0] 
	var random_z =  randi() % int(z_range[1]-z_range[0]) + 1 + z_range[0]
	var random_pos = Vector3(random_x, -4.292, random_z)

	return(random_pos)

func load_islands():
	var ilhas_positions = [spawn_point]
	for i in data_ilhas:
		var new_island = island_scene.instance()
		$Ilhas.add_child(new_island, true)
	
	var count = 0
	for i in data_ilhas:
		$Ilhas.get_child(count).name = i
		var deco = $Ilhas.get_child(count).get_child(4)
		var decoration = deco.get_children()
		for d in decoration:
			if d.name == data_ilhas[i].icon:
				d.visible = true
		$Ilhas.get_child(count).connect("body_entered",$".","call_popup",[$Ilhas.get_child(count).name])
		var ideal_distance = false
		var safe_guard = 0
		while !ideal_distance:
			safe_guard += 1
			var count_errados = 0
			var target_position
			for p in ilhas_positions:
				target_position = reposition_random()
				var distance = target_position.distance_to(p)
				if distance < 50:
					count_errados += 1
					print("OOPS")
			if count_errados == 0:
				$Ilhas.get_child(count).set_translation(target_position)
				ilhas_positions.append(target_position)
				ilhas_positions_dictionary[i] = target_position
				ideal_distance = true
			if safe_guard > 1000000:
				safe_guard = 0
				randomize()
		count += 1
	print(ilhas_positions_dictionary)

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_FOCUS_IN:
		print("focus in")
	elif what == MainLoop.NOTIFICATION_WM_FOCUS_OUT:
		print("focus out")
		current_focus_out += 1


func save_data():
	var file
	
	file  = File.new()
	
	file.open(path_data_ilhas_respostas, File.WRITE)
	
	file.store_line(to_json(data_ilhas_respostas))
	
	file.close()



#var data_ilhas = {}
#var data_ilhas_respostas = {}
func load_data():
	
	# Recuperar dados dos Questionários:
	var file = File.new()
	
	if not file.file_exists(path_data_ilhas):
		return
	
	file.open(path_data_ilhas, file.READ)
	
	var text = file.get_as_text()
	
	data_ilhas = parse_json(text)
	
	file.close()
	
	# Recuperar dados das respostas da ultima seção:
	
	file = File.new()
	
	if not file.file_exists(path_data_ilhas_respostas):
		return
	
	file.open(path_data_ilhas_respostas, file.READ)
	
	text = file.get_as_text()
	
	data_ilhas_respostas = parse_json(text)
	
	for i in data_ilhas:
		print(i)
		if !data_ilhas_respostas.has(i):
			data_ilhas_respostas[i] = data_ilhas[i]["questions"]
			for q in data_ilhas_respostas[i]:
				data_ilhas_respostas[i][q] = {
					"data_inicial":null,
					"data_final":null,
					"alternativa_escolhida":null,
					"quantidade_perda_de_foco":null
					}
	#print(data_ilhas)
	file.close()
	
	# Recuperar dados dos Questionários:
	file = File.new()
	
	if not file.file_exists(path_data_ilhas):
		return
	
	file.open(path_data_ilhas, file.READ)
	
	text = file.get_as_text()
	
	data_ilhas = parse_json(text)
	
	file.close()

func trickUpdate(amount):
	if (amount != $boat/trickTrack.mesh.material.get_shader_param('amount')):
		$boat/trickTrack.mesh.material.set_shader_param('amount', amount)

func tileRender():

	var dist = 0
	var boatPos = $boat.translation
	var positions = {
		"centro":Vector3(round(boatPos.x * 0.011111) * 90,oceanY,round(boatPos.z * 0.011111) * 90),
		"cima":Vector3((round(boatPos.x * 0.011111) * 90) + 90,oceanY,round(boatPos.z * 0.011111) * 90),
		"baixo":Vector3((round(boatPos.x * 0.011111) * 90) -90,oceanY,round(boatPos.z * 0.011111) * 90),
		"esquerda":Vector3(round(boatPos.x * 0.011111) * 90,oceanY,(round(boatPos.z * 0.011111) * 90) - 90),
		"direita":Vector3((round(boatPos.x * 0.011111) * 90),oceanY,(round(boatPos.z * 0.011111) * 90) + 90),
		"cd":Vector3((round(boatPos.x * 0.011111) * 90) + 90,oceanY,(round(boatPos.z * 0.011111) * 90) + 90),
		"ce":Vector3((round(boatPos.x * 0.011111) * 90) + 90,oceanY,(round(boatPos.z * 0.011111) * 90) - 90),
		"bd":Vector3((round(boatPos.x * 0.011111) * 90) - 90,oceanY,(round(boatPos.z * 0.011111) * 90) + 90),
		"be":Vector3((round(boatPos.x * 0.011111) * 90) - 90,oceanY,(round(boatPos.z * 0.011111) * 90) - 90),
		}
	
	for p in positions:
		if positions[p].distance_to(get_node("TilesRendered/"+p).translation) > 40:
			get_node("TilesRendered/"+p).translation.x = positions[p].x
			get_node("TilesRendered/"+p).translation.z = positions[p].z
			
			
	#print(positions)
	

func boatAnimation(active):
	if active:
		t = ($TilesRendered.get_child(0).mesh.material.get_shader_param('amount')*0.5) * sin(OS.get_ticks_msec()*(2*PI*0.0005*$TilesRendered.get_child(0).mesh.material.get_shader_param('amount')))
		$boat.translation.y = (t)+0.5
		
		#$boat.rotation_degrees.x += t*0.1
		#$boat.rotation_degrees.y -= t*0.1
		#$boat.rotation_degrees.z -= t*0.1
		#$boat/Pivot/Camera.rotation_degrees.x -= t*0.1
		#$boat/Pivot/Camera.rotation_degrees.y += t*0.1
		#$boat/Pivot/Camera.rotation_degrees.z += t*0.1


func next_question():
	if $boat/Camroot/h/v/Camera/UI/MargemPopup/ComecarButton.visible:
		$boat/Camroot/h/v/Camera/UI.play_dissolve_hide("TPop2")
		$boat/Camroot/h/v/Camera/UI/MargemPopup/FecharTop.visible = false
		$boat/Camroot/h/v/Camera/UI/MargemPopup/FecharBottom.visible = false
		$boat/Camroot/h/v/Camera/UI/MargemPopup/ComecarButton.visible = false
		$boat/Camroot/h/v/Camera/UI.resize()
		$boat/Camroot/h/v/Camera/UI.play_dissolve_show("RichTextLabel")
		$boat/Camroot/h/v/Camera/UI.play_dissolve_show("Alternativas")
	var TTS_alternativas = ""
	for r in data_ilhas_respostas:
		#print(r)
		var shown = false
		if r == current_island and !shown:
			for q in data_ilhas_respostas[r]:
				#print(q)
				if data_ilhas_respostas[r][q].alternativa_escolhida == null and !shown:
					#print(data_ilhas[r]["questions"][q])
					$boat/Camroot/h/v/Camera/UI/MargemPopup/RichTextLabel.bbcode_text = "[center]"+data_ilhas[r]["questions"][q].questao
					current_question = q
					data_ilhas_respostas[current_island][current_question].data_inicial = OS.get_datetime()
					current_focus_out = 0
					var count = 0
					
					for node in range($boat/Camroot/h/v/Camera/UI/Alternativas.get_child_count()):
							var child = $boat/Camroot/h/v/Camera/UI/Alternativas.get_child(node)
							
							for n in range(child.get_child_count()):
									var last_child = child.get_child(n)
									#print(q)
									if data_ilhas[current_island]["questions"][q]["alternativas"][last_child.name] != null:
										last_child.text = last_child.name.to_upper()+") "+data_ilhas[current_island]["questions"][q]["alternativas"][last_child.name]
										print(" ... Alternativa "+ (last_child.name.to_upper()+" ... "+data_ilhas[current_island]["questions"][q]["alternativas"][last_child.name]))
										if child.name == "V":
											TTS_alternativas = TTS_alternativas + " ... Alternativa "+ (last_child.name.to_upper()+" ... "+data_ilhas[current_island]["questions"][q]["alternativas"][last_child.name])
										count += 1
									else:
										last_child.text = ""
										last_child.visible = false
									shown = true
	if current_mode == "Baixa Visão":
		print(TTS_alternativas)
		last_said = "... "+data_ilhas[current_island]["questions"][current_question].questao + "..." + TTS_alternativas
		$TTS.speak("... "+data_ilhas[current_island]["questions"][current_question].questao + "..." + TTS_alternativas)
	$boat/Camroot/h/v/Camera/UI.alternativas_orientation(OS.window_size)
	if current_mode != "Mão Única":
		$boat/Camroot/h/v/Camera/UI/MargemPopup/ComecarButton.grab_focus()

func responder(resposta):
	if current_island and current_question:
		data_ilhas_respostas[current_island][current_question].alternativa_escolhida = resposta
		data_ilhas_respostas[current_island][current_question].data_final = OS.get_datetime()
		data_ilhas_respostas[current_island][current_question].quantidade_perda_de_foco = current_focus_out
		#print(data_ilhas_respostas[current_island][current_question])
		$boat/Camroot/h/v/Camera/UI.play_dissolve_show("RichTextLabel")
		$boat/Camroot/h/v/Camera/UI.play_dissolve_show("Alternativas")
		var list = data_ilhas_respostas[current_island].keys()
		for c in $boat/Camroot/h/v/Camera/UI/Alternativas.get_children():
			for ch in c.get_children():
				ch.visible = true
		if list[len(list)-1] == current_question:
			print("FIM")
			$boat/Camroot/h/v/Camera/UI/Alternativas/HLeft.visible = false
			$boat/Camroot/h/v/Camera/UI/Alternativas/HRight.visible = false
			$boat/Camroot/h/v/Camera/UI/Alternativas/V.visible = false
			$boat/Camroot/h/v/Camera/UI/MargemPopup/RichTextLabel.visible = false
			$boat/Camroot/h/v/Camera/UI/MargemPopup/TPop2.visible = true
			$boat/Camroot/h/v/Camera/UI/MargemPopup/TPop2.self_modulate.a = 1.0
			get_node("Ilhas/"+current_island+"/Star").visible = true
			close_popup()
		else:
			next_question()

func show_previous_island():
	print(islands_list.find(current_shown_island))
	if islands_list.find(current_shown_island)-1 >= 0:
		fast_travel_load_island(islands_list[islands_list.find(current_shown_island)-1])
	else:
		fast_travel_load_island(islands_list[len(islands_list)-1])

func show_next_island():
	print(islands_list.find(current_shown_island))
	if islands_list.find(current_shown_island)+1 <= len(islands_list)-1:
		fast_travel_load_island(islands_list[islands_list.find(current_shown_island)+1])
	else:
		fast_travel_load_island(islands_list[0])

func fast_travel_load_island(island):
	current_shown_island = island
	var file = File.new()
	if file.file_exists("res://assets/UI/"+data_ilhas[island].ilha_img):
		var image = load("res://assets/UI/"+data_ilhas[island].ilha_img)
		$boat/Camroot/h/v/Camera/UI/MargemPopup/MenuFasTravel/TPop2.set_texture(image)
	else:
		print("Não possui imagem.")
	file.close()
	$boat/Camroot/h/v/Camera/UI/MargemPopup/MenuFasTravel/RichTextLabel.bbcode_text = "[center]"+data_ilhas[island].nome

func call_fast_travel_menu():
	current_menu = "fast travel"
	$boat/Camroot/h/v/Camera/UI/MargemPopup/MenuFasTravel.visible = true
	$boat/Camroot/h/v/Camera/UI/MargemPopup/MenuFasTravel/Ilha.grab_focus()
	islands_list = []
	for i in data_ilhas:
		islands_list.append(i)
	current_shown_island = islands_list[0]
	fast_travel_load_island(current_shown_island)
	
	

func call_options_menu():
	current_menu = "options"
	$boat/Camroot/h/v/Camera/UI/MargemPopup/MenuOptions.visible = true
	$boat/Camroot/h/v/Camera/UI/MargemPopup/MenuOptions/Modo.grab_focus()

func call_esc_menu():
	if current_menu == "":
		current_menu = "esc_menu"
		$boat/Camroot/h/v/Camera/UI.play_dissolve_show("MargemPopup")
		$boat/Camroot/h/v/Camera/UI.popup_active = true
		$boat/Camroot.camera_control = false
		$boat/Camroot.camera_control = false
		$boat.movement_control = false
		$boat/Camroot/h/v/Camera/UI/MargemPopup/ComecarButton.visible = false
		$boat/Camroot/h/v/Camera/UI/MargemPopup/FecharBottom.visible = false
		$boat/Camroot/h/v/Camera/UI/MargemPopup/FecharTop.visible = false
		$boat/Camroot/h/v/Camera/UI/MargemPopup/TPop2.visible = false
		$boat/Camroot/h/v/Camera/UI/MargemPopup/Options.visible = true
		$boat/Camroot/h/v/Camera/UI/MargemPopup/fast_travel.visible = true
		$boat/Camroot/h/v/Camera/UI/MargemPopup/Retomar.visible = true
		$boat/Camroot/h/v/Camera/UI/MargemPopup/Sair.visible = true
		$boat/Camroot.camera_mouse_capture(false)

func call_popup(player, island):
	if $boat.movement_control and !get_node("Ilhas/"+island+"/Star").visible and start_timer:
		current_menu = "question"
		var file = File.new()
		if file.file_exists("res://assets/UI/"+data_ilhas[island].ilha_img):
			var image = load("res://assets/UI/"+data_ilhas[island].ilha_img)
			$boat/Camroot/h/v/Camera/UI/MargemPopup/TPop2.set_texture(image)
		else:
			print("Não possui imagem.")
		file.close()
		if current_mode == "Mão Única":
			$boat/Camroot/h/v/Camera/UI/MargemPopup/ComecarButton.grab_focus()
		$boat/Camroot/h/v/Camera/UI/MargemPopup/TPop2.visible = true
		$boat/Camroot/h/v/Camera/UI.play_dissolve_show("MargemPopup")
		$boat/Camroot/h/v/Camera/UI/MargemPopup/FecharTop.visible = true
		$boat/Camroot/h/v/Camera/UI/MargemPopup/FecharBottom.visible = true
		$boat/Camroot/h/v/Camera/UI/MargemPopup/ComecarButton.visible = true
		$boat/Camroot/h/v/Camera/UI.positions_setter()
		$boat/Camroot/h/v/Camera/UI.popup_active = true
		$boat/Camroot/h/v/Camera/UI/MargemPopup.modulate = Color(1,1,1,0.0)
		$boat/Camroot.camera_control = false
		$boat/Camroot.camera_control = false
		$boat.movement_control = false
		$boat/Camroot.camera_mouse_capture(false)
		current_island = island
		if current_mode == "Baixa Visão":
			last_said = "Você deseja começar a ilha "+data_ilhas[current_island].nome+"? ... as opções são: começar e fechar."
			$TTS.speak("Você deseja começar a ilha "+data_ilhas[current_island].nome+"? ... as opções são: começar e fechar.")

func close_to_esc_menu():
	$boat/Camroot/h/v/Camera/UI/MargemPopup/MenuOptions.visible = false
	$boat/Camroot/h/v/Camera/UI/MargemPopup/MenuFasTravel.visible = false
	if current_menu == "options":
		current_mode = modos_de_jogo[modos_de_jogo.find($boat/Camroot/h/v/Camera/UI/MargemPopup/MenuOptions/RichTextLabel.bbcode_text.replace("[center]", ""),0)]
	current_menu = "esc_menu"
	if current_mode == "Mão Única":
		$boat/Camroot/h/v/Camera/UI/MargemPopup/Retomar.grab_focus()

func close_popup():
	current_menu = ""
	$boat/Camroot/h/v/Camera/UI.play_dissolve_hide("MargemPopup")
	$boat/Camroot/h/v/Camera/UI/Alternativas/HLeft.visible = false
	$boat/Camroot/h/v/Camera/UI/Alternativas/HRight.visible = false
	$boat/Camroot/h/v/Camera/UI/Alternativas/V.visible = false
	$boat/Camroot/h/v/Camera/UI/MargemPopup/Options.visible = false
	$boat/Camroot/h/v/Camera/UI/MargemPopup/fast_travel.visible = false
	$boat/Camroot/h/v/Camera/UI/MargemPopup/Retomar.visible = false
	$boat/Camroot/h/v/Camera/UI/MargemPopup/Sair.visible = false
	$boat/Camroot/h/v/Camera/UI.positions_setter()
	$boat/Camroot/h/v/Camera/UI.popup_active = false
	$boat/Camroot/h/v/Camera/UI/MargemPopup.modulate = Color(1,1,1,1)
	$boat/Camroot.camera_control = true
	$boat/Camroot.camera_control = true
	$boat.movement_control = true
	$boat/Camroot.camera_mouse_capture(true)

func next_mode():
	if current_mode == "Mão Única":
		$boat/Camroot/h/v/Camera/UI/MargemPopup/MenuOptions/Modo.grab_focus()
	if $boat/Camroot/h/v/Camera/UI/MargemPopup/MenuOptions/RichTextLabel.bbcode_text == "[center]"+modos_de_jogo[len(modos_de_jogo)-1]:
		print("[center]" + modos_de_jogo[0])
		$boat/Camroot/h/v/Camera/UI/MargemPopup/MenuOptions/RichTextLabel.bbcode_text = "[center]" + modos_de_jogo[0]
	else: 
		print(modos_de_jogo.find($boat/Camroot/h/v/Camera/UI/MargemPopup/MenuOptions/RichTextLabel.bbcode_text.replace("[center]", ""),0))
		$boat/Camroot/h/v/Camera/UI/MargemPopup/MenuOptions/RichTextLabel.bbcode_text = "[center]" + modos_de_jogo[modos_de_jogo.find($boat/Camroot/h/v/Camera/UI/MargemPopup/MenuOptions/RichTextLabel.bbcode_text.replace("[center]", ""),0)+1]

func previous_mode():
	if current_mode == "Mão Única":
		$boat/Camroot/h/v/Camera/UI/MargemPopup/MenuOptions/Modo.grab_focus()
	if $boat/Camroot/h/v/Camera/UI/MargemPopup/MenuOptions/RichTextLabel.bbcode_text == "[center]"+modos_de_jogo[0]:
		print("[center]" + modos_de_jogo[len(modos_de_jogo)-1])
		$boat/Camroot/h/v/Camera/UI/MargemPopup/MenuOptions/RichTextLabel.bbcode_text = "[center]" + modos_de_jogo[len(modos_de_jogo)-1]
	else: 
		print(modos_de_jogo.find($boat/Camroot/h/v/Camera/UI/MargemPopup/MenuOptions/RichTextLabel.bbcode_text.replace("[center]", ""),0))
		$boat/Camroot/h/v/Camera/UI/MargemPopup/MenuOptions/RichTextLabel.bbcode_text = "[center]" + modos_de_jogo[modos_de_jogo.find($boat/Camroot/h/v/Camera/UI/MargemPopup/MenuOptions/RichTextLabel.bbcode_text.replace("[center]", ""),0)-1]

func tp_to(island):
	start_timer = false
	$boat.translation = Vector3(ilhas_positions_dictionary[island].x,$boat.translation.y,ilhas_positions_dictionary[island].z+15)
	Input.action_press("ui_up", 1.0)
	Input.action_release("ui_up")

func _physics_process(delta: float) -> void:
	boatAnimation(true)
	
	if current_mode == "Mão Única" and current_focus_node == "ComecarButton" and !$boat/Camroot/h/v/Camera/UI/MargemPopup/ComecarButton.has_focus():
		$boat/Camroot/h/v/Camera/UI/MargemPopup/ComecarButton.grab_focus()
	
	if Input.is_action_just_pressed("ui_cancel"):
		if current_menu == "":
			call_esc_menu()
			if current_mode == "Mão Única":
				$boat/Camroot/h/v/Camera/UI/MargemPopup/Retomar.grab_focus()
		elif current_menu == "esc_menu":
			close_popup()
		elif current_menu == "options":
			close_to_esc_menu()
	


func _on_TimerRender_timeout():
	tileRender()
	start_timer = true
	
	




func _on_FecharTop_button_down():
	close_popup()


func _on_ComecarButton_pressed():
	next_question()




func _on_a_button_down():
	responder("a")


func _on_c_button_down():
	responder("c")


func _on_e_button_down():
	responder("e")


func _on_b_button_down():
	responder("b")


func _on_d_button_down():
	responder("d")



func _on_Options_button_down():
	call_options_menu()

func _on_fast_travel_button_down():
	call_fast_travel_menu()

func _on_FecharBottom_button_down():
	close_to_esc_menu()


func _on_next_button_down():
	next_mode()


func _on_previous_button_down():
	previous_mode()


func _on_previousIsland_button_down():
	show_previous_island()


func _on_nextIsland_button_down():
	show_next_island()




func _on_Audio_button_down():
	tp_to(current_shown_island)
	$boat/Camroot/h/v/Camera/AnimationPlayer.queue("fade_out")
	$boat/Camroot/h/v/Camera/AnimationPlayer.queue("fade_in")
	close_to_esc_menu()
	close_popup()
