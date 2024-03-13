extends Area2D


func _on_Fly_body_entered(body):
	$AnimatedSprite.visible = false
	$proximity.playing = false
	$sfx.playing = true
