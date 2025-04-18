extends CharacterBody2D

@export var SPEED := 93.0  # 倒过来就是 39 ( • ̀ω•́ )✧ （秒）
@export var JUMP_VELOCITY = -239.0  # 爱 miku （秒）
@export var COYOTE_TIME := 0.239  # 土狼时间窗口 （秒）

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")  # 将项目设置中的重力与刚体节点同步s
var last_grounded_time := 0.0  # 最后一次接触地面的时间戳 （秒）

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D  # 后期请替换成 AnimationTree 哦~

func _physics_process(delta):
# 添加重力
	if not is_on_floor():
		velocity.y += gravity * delta

# 横向移动
	var direction := Input.get_axis("left", "right")  # 获取输入方向:-1, 0, 1
	velocity.x = direction * SPEED if direction else move_toward(velocity.x, 0, SPEED)

# 更新移动和地面状态
	move_and_slide()

# 记录最后一次在地面的时间
	if is_on_floor():
		last_grounded_time = Time.get_ticks_msec() / 1000.0  # 将毫秒转换为（秒）

# 处理跳跃
	if Input.is_action_just_pressed("jump") and _is_on_floor():  # 如果玩家刚刚按下跳跃键，并且真！在地面上
		velocity.y = JUMP_VELOCITY
		last_grounded_time = Time.get_ticks_msec() / 1000.0 - (COYOTE_TIME + 0.1)  # 只需比 COYOTE_TIME 大即可		

#region 动画控制v0.1 【if 函数直接控制】
# 翻转精灵图
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
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

# 真！在地面上の检测：实际在地面，或处于土狼时间窗口内
func _is_on_floor() -> bool:
	var current_time = Time.get_ticks_msec() / 1000.0  # 将毫秒转换为（秒）
	return is_on_floor() or (current_time - last_grounded_time <= COYOTE_TIME)
