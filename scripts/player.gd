extends CharacterBody2D

const SPEED := 93.0  # 倒过来就是 39 ( • ̀ω•́ )✧
const JUMP_VELOCITY = -239.0  # 爱 miku

# 将项目设置中的重力与刚体节点同步
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D  # 后期请替换成 AnimationTree 哦~
@onready var coyote_timer: Timer = $CoyoteTimer  # 单次触发的timer节点

func _physics_process(delta):
	# 添加重力
	if not is_on_floor():
		velocity.y += gravity * delta

	# 土狼时间
	

	# 处理跳跃
	if Input.is_action_just_pressed("jump") and is_on_floor():  # 如果玩家刚刚按下 “C” 并且 在地面上
		velocity.y = JUMP_VELOCITY

	# 获取输入方向:-1, 0, 1
	var direction := Input.get_axis("left", "right")

	# 翻转精灵图
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

#region 动画控制v0.1 （if 函数直接控制 (,,>﹏<,,) ）
	# 播放动画
	if is_on_floor():
		if direction == 0:
			if Input.is_action_pressed("lol"):
				animated_sprite.play("lol")
			else: animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
#endregion

	# 应用移动
	if direction:
		velocity.x = direction * SPEED  # 计算当前移速
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)  # 当前移速， 目标移速， 速度

	move_and_slide()
