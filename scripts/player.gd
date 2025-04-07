extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const RUN_MAX_SPEED := 96.0
const RUN_ACCELERATION := 800.0
const RUN_DECELERATION := 1600.0
const JUMP_VELOCITY = -239.0


func _physics_process(delta: float) -> void:
	# 添加重力
	if not is_on_floor():
		velocity += get_gravity() * delta

	#region 跳跃
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	#endregion
	
	#region 移动
	# 获取输入方向和处理移动方向
	var direction := Input.get_axis("left", "right")
	
	# 计算目标速度和加速度
	var target_speed := direction * RUN_MAX_SPEED  #计算目标速度
	var run_speed := RUN_DECELERATION  # 默认使用减速
	if direction:
	
	# 当输入方向与当前速度方向相反时保持使用DECELERATION，否则使用ACCELERATION
		if velocity.x == 0 || sign(velocity.x) == sign(direction):
			run_speed = RUN_ACCELERATION
	
	# 平滑调整速度
	velocity.x = move_toward(velocity.x, target_speed, run_speed * delta)
	# 执行移动
	move_and_slide()
	#endregion
	
