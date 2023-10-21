extends STTRunner

var stt = STTRunner.new()
var config = STTConfig.new()
var queue = STTQueue.new()

func _ready():
	config.set_hmm_dirname("res://stt/hmm")
	config.set_dict_filename("res://stt/en-us.dict")
	config.set_kws_filename("res://stt/colors.kws")
	
	var err = config.init()
	if err != STTError.OK:
		print(STTError.get_error_string(err))
		return
	
	stt.set_config(config)
	stt.set_queue(queue)
	
	err = stt.start()
	if err != STTError.OK:
		print(STTError.get_error_string(err))
		return
	set_process(true)

func _process(delta):
	if not queue.empty():
		print(queue.get())
