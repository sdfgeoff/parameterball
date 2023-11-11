extends Node2D


@export var BALL_SIZE: int = 8
@export var BALL_SPEED: int = 80

@export var PAD_LENGTH: int = 20
@export var PAD_SPEED: int = 150

@export var COURT_HEIGHT: int = 400
@export var COURT_WIDTH: int = 600

@export var GRAVITY_X: int = 0
@export var GRAVITY_Y: int = 0

var ball_velocity = Vector2(1.0, 0.0)



func spin():
	COURT_HEIGHT = randi_range(50, 400)
	COURT_WIDTH = randi_range(60, 600)
	$court.scale.x = COURT_WIDTH
	$court.scale.y = COURT_HEIGHT
	$separator.scale.y = COURT_HEIGHT
	


	BALL_SIZE = min(randi_range(2, 100), COURT_WIDTH / 2, COURT_HEIGHT / 2)
	$ball.scale.x = BALL_SIZE
	$ball.scale.y = BALL_SIZE

	BALL_SPEED = randi_range(80, 500)
	ball_velocity = ball_velocity.normalized() * BALL_SPEED

	PAD_LENGTH = min(randi_range(10, 200), COURT_HEIGHT / 2);
	$left.scale.y = PAD_LENGTH
	$right.scale.y = PAD_LENGTH
	
	PAD_SPEED = randi_range(80, 200)
	
	GRAVITY_X = randi_range(-BALL_SPEED, BALL_SPEED)
	GRAVITY_Y = randi_range(-BALL_SPEED, BALL_SPEED)
	
	$left.position.x = -COURT_WIDTH / 2 + 50
	$left.position.y = clamp($left.position.y, -COURT_HEIGHT / 2 + PAD_LENGTH / 2 , COURT_HEIGHT / 2 - PAD_LENGTH / 2)
	$right.position.x = COURT_WIDTH / 2 - 50
	$right.position.y = clamp($right.position.y, -COURT_HEIGHT / 2 - PAD_LENGTH / 2, COURT_HEIGHT / 2 + PAD_LENGTH / 2)
	
	


func _ready():
	spin()

	

func _process(delta):
	
	var screen_size = get_viewport_rect().size
	var pad_size = $left.scale
	
	var ball_pos = $ball.position
	var left_rect = Rect2( $left.position - pad_size*0.5, pad_size )
	var right_rect = Rect2( $right.position - pad_size*0.5, pad_size )

	# Integrate new ball positioy
	ball_velocity += Vector2(GRAVITY_X, GRAVITY_Y) * delta
	ball_pos += ball_velocity * delta

	# Flip when touching roof or floor
	if ((ball_pos.y < -COURT_HEIGHT / 2 + BALL_SIZE / 2 and ball_velocity.y < 0) or (ball_pos.y > COURT_HEIGHT / 2 - BALL_SIZE / 2 and ball_velocity.y > 0)):
		ball_velocity.y = -ball_velocity.y
		
	# Flip, change direction and increase speed when touching pads
	if ((left_rect.has_point(ball_pos) and ball_velocity.x < 0) or (right_rect.has_point(ball_pos) and ball_velocity.x > 0)):
		var speed = ball_velocity.length()
		ball_velocity.x = -ball_velocity.x
		#ball_velocity.y = (randf()*2.0 - 1) * BALL_SPEED
		ball_velocity = ball_velocity.normalized() * speed * 1.1
		
	# Check gameover
	if (ball_pos.x < - COURT_WIDTH / 2 or ball_pos.x > COURT_WIDTH / 2):
		spin()
		$ball.position.x = 0
		$ball.position.y = 0
		ball_velocity.x = randf()
		ball_velocity.y = randf()
		ball_velocity = ball_velocity.normalized() * BALL_SPEED

	else:
		$ball.position = ball_pos

	move_paddles(delta)



func move_paddles(delta: float):
	# Move left pad
	var left_pos = get_node("left").position

	if (left_pos.y > -COURT_HEIGHT / 2 + PAD_LENGTH / 2 and Input.is_action_pressed("left_move_up")):
		left_pos.y += -PAD_SPEED * delta
	if (left_pos.y < COURT_HEIGHT / 2 - PAD_LENGTH / 2 and Input.is_action_pressed("left_move_down")):
		left_pos.y += PAD_SPEED * delta

	get_node("left").position = left_pos

	# Move right pad
	var right_pos = get_node("right").position

	if (right_pos.y > -COURT_HEIGHT / 2 + PAD_LENGTH / 2 and Input.is_action_pressed("right_move_up")):
		right_pos.y += -PAD_SPEED * delta
	if (right_pos.y < COURT_HEIGHT / 2 - PAD_LENGTH / 2 and Input.is_action_pressed("right_move_down")):
		right_pos.y += PAD_SPEED * delta

	get_node("right").position = right_pos
