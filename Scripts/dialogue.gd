extends Control


signal dialog_finished
@export_file("*.json") var d_file

var dialogue = []
var current_dialogue_id = 0
var dialogue_active = false

func _ready():
	$NinePatchRect.visible = false
	
func start():
	if dialogue_active:
		return
	dialogue_active = true
	$NinePatchRect.visible = true
	dialogue = load_dialogue()
	current_dialogue_id = -1
	next_dialogue()

func load_dialogue():
	var file = FileAccess.open("res://Dialogue/justin_dialogue.json", FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content
	

func _input(event):
	if !dialogue_active:
		return
	if event.is_action_pressed("interact"):
		next_dialogue()

func next_dialogue():
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogue):
		dialogue_active = false
		$NinePatchRect.visible = false
		emit_signal("dialog_finished")
		return
	
	$NinePatchRect/DialogueText.text = dialogue[current_dialogue_id]['name']
	$NinePatchRect/DialogueText.text = dialogue[current_dialogue_id]['text']

