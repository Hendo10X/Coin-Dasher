extends Area2D

@export var screensize: Vector2

func _ready():
	$Tween.property($AnimatedSprite2D, 'scale',
	$AnimatedSprite2D.scale, $AnimatedSprite2D.scale * 3,0.3,
	Tween.TRANS_QUAD,
	Tween.EASE_IN_OUT)

func pickup():
	monitoring = false
	$Tween.start()

func _on_Tween_tween_completed(object, key):
		queue_free()
