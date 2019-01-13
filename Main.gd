extends Node

export (PackedScene) var Mob
var score

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
    randomize()

#func _process(delta):
#    # Called every frame. Delta is time since last frame.
#    # Update game logic here.
#    pass


func game_over():
    $ScoreTimer.stop()
    $MobTimer.stop()
    
func start_game():
    score = 0
    $Player.start($StartPosition.position)
    $StartTimer.start()

func _on_StartTimer_timeout():
    $MobTimer.start()
    $ScoreTimer.start()

func _on_ScoreTimer_timeout():
    score += 1

func _on_MobTimer_timeout():
    # Choose a random location on Path2D.
    $MobPath/MobSpawnLocation.set_offset(randi())
    
    # Create a Mob instance and add it to the scene.
    var mob = Mob.instance()
    add_child(mob)
    
    # Set the mob's direction perpendicular to the path direction.
    var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
    
    # Set the mob's position to a random location.
    mob.position = $MobPath/MobSpawnLocation.position
    
    # Add some randomness to the direction.
    direction += rand_range(-PI / 4, PI / 4)
    mob.rotation = direction
    
    # choose the velocity
    mob.set_linear_velocity(Vector2(rand_range(mob.min_speed, mob.max_speed), 0).rotated(direction))
