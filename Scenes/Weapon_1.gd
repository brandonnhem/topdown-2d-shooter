extends Area2D

func _on_body_entered(body: Node2D) -> void:
	#visible = false
	print("Player entered Gun Area2D")
	queue_free()
	body.add_weapon("gun")
	

