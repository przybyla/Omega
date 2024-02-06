extends Node

#database to hold array of dicts containing data of all quests in game
#at the start of game this can be loaded from a .JSON file
var quest_database
#store this persistently on file, also save information about quest progress
var active_quests = {}

func _ready():
	setup_database()

func setup_database():
	var json_as_text = FileAccess.get_file_as_string("res://Quests/quest_data.json")
	
	var json_as_dict = JSON.parse_string(json_as_text)
	if json_as_dict:
		#print(json_as_dict)
		quest_database = json_as_dict

func activate_quest(quest_id):
	#get correct quest from database
	var quest_dict = null
	for quest in quest_database:
		if quest.id == quest_id:
			quest_dict = quest
			break
	#if quest doesn't exist, print error and cease
	if quest_dict == null:
		print("ERROR: Wrong questID. Quest does not exist in the database.")
		return
	#insert to active quests
	active_quests[quest_id] = quest_dict
	#debug
	#print(active_quests)

func progress_quest(quest_id):
	if active_quests.has(quest_id):
		active_quests[quest_id].quest_progress += 1

func complete_quest(quest_id):
	if active_quests.has(quest_id):
		active_quests[quest_id].quest_completed = true
