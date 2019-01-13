extends RigidBody2D

export (int) var min_speed  # minimum speed range 
export (int) var max_speed  # maximum speed range

var mob_types = ['walk', 'swim', 'fly']

func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
    $AnimatedSprite.animation = mob_types[randi() % mob_types.size()]

#func _process(delta):
#    # Called every frame. Delta is time since last frame.
#    # Update game logic here.
#    pass


func _on_VisibilityNotifier2D_screen_exited():
    queue_free()
