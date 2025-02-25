extends Label

func _ready():
	await get_tree().process_frame  #  tree is loaded
	var player = get_tree().get_first_node_in_group("player")  # Findplayer
	
	if player:
		player.health_changed.connect(update_health)
		update_health(player.health)  # Set initial health value
		print("Health label connected to player")  # for debug

func update_health(new_health):
	print("Updating health label:", new_health)  # debug
	text = "Health: " + str(new_health)
