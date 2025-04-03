extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -239.0


func _physics_process(delta: float) -> void:
	# 添加重力
	if not is_on_floor():
		velocity += get_gravity() * delta

	# 处理跳跃
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# 获取输入方向和处理移动方向
	# 自定义输入
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
