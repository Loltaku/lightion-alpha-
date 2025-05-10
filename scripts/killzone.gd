extends Area2D   #这是一个万用死亡检测哦~

@onready var timer: Timer = $Timer   #链接到重生缓冲计时器

func _on_body_entered(body: Node2D) -> void:   #当玩家进入死亡区域时发出信号
	print("You died!")
	timer.start()   #重生缓冲倒计时开始


func _on_timer_timeout() -> void:   #倒计时结束发出信号
	get_tree().reload_current_scene()   #访问场景树并重新加载它
