extends Area2D

@export var damage: int = 1

func _on_Hazard_body_entered(body):
	print("Hazard touched!")  
	if body is CharacterBody2D:
		print("Player detected! Taking damage.")
		body.take_damage(damage)
