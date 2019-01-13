extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
signal hit 

export (int) var speed  # how fast the player will move 
var screensize  # size of the game window

func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
    screensize = get_viewport_rect().size
    # hide()


func _process(delta):
    # Called every frame. Delta is time since last frame.
    # Update game logic here.
    var velocity = Vector2()
    if Input.is_action_pressed('ui_right'):
        velocity.x += 1
    if Input.is_action_pressed('ui_left'):
        velocity.x -= 1
    if Input.is_action_pressed('ui_up'):
        velocity.y -= 1
    if Input.is_action_pressed('ui_down'):
        velocity.y += 1
    
    if velocity.length() > 0:
        velocity = velocity.normalized() * speed
        $AnimatedSprite.play()
    else:
        $AnimatedSprite.stop()
        
    position += velocity * delta
    position.x = clamp(position.x, 0, screensize.x)
    position.y = clamp(position.y, 0, screensize.y)
    
    
    if velocity.x != 0:
        $AnimatedSprite.animation = 'right'
        $AnimatedSprite.flip_v = false
        $AnimatedSprite.flip_h = velocity.x < 0
    elif velocity.y != 0:
        $AnimatedSprite.animation = 'up'
        $AnimatedSprite.flip_v = velocity.y > 0
        
    """
    if velocity.x < 0:
        $AnimatedSprite.flip_h = true
    else:
        $AnimatedSprite.flip_h = false
    """
    
        


func _on_Player_body_entered(body):
    hide()
    emit_signal('hit')
    $CollisionShape2D.disabled = true
    
func start(pos):
    position = pos
    show()
    $CollisionShape2D.disabled = false
    