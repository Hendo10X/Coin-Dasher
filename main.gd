extends Node

@export var coin: PackedScene
@export var play_time: int

var level
var score
var time_left
var screensize
var playing = false


func _ready():
	randomize()
	screensize = get_viewport().get_visible_rect().size
	$Player.screensize = screensize
	$Player.hide()
	
	
func _process(delta):
	if playing and $CoinsContainer.get_child_count() == 0:
		level +=1
		time_left += 5
		spawn_coins()

func new_game():
	playing = true
	level = 1
	score = 0
	time_left = play_time
	$Player.start($PlayerStart.position)
	$Player.show()
	$Gametimer.start()
	spawn_coins()
	$HUD.update_score(score)
	$HUD.update_timer(time_left)
	
	
func spawn_coins():
	for i in range(4 + level):
		var c = coin.instantiate()
		$CoinsContainer.add_child(c)
		c.screensize = screensize
		c.position = Vector2(randi_range(0,screensize.x), randi_range(0, screensize.y))
		
		
func _on_gametimer_timeout():
	time_left -= 1
	$HUD.update_timer(time_left)
	if time_left < 0:
		game_over()

func _on_player_pickup():
	score +=1
	$HUD.update_score(score)

func _on_player_hurt():
	game_over()

	
func game_over():
	playing = false
	$Gametimer.stop()
	for coin in $CoinsContainer.get_children():
		coin.queue_free()
	$HUD.show_gameover()
	$Player._die()



