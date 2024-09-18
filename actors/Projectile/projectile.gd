extends Area2D

var velocity: Vector2 = Vector2(0, 0)
var globSpeed: float = 0
var globType: int
var Pickupable: bool = false
var parent: CharacterBody2D

func fire(direction: Vector2, speed: float, type : int):
	globType = type
	globSpeed = speed
	if type:
		look_at(direction)
		scale = Vector2(2,2)
		velocity = direction

func _physics_process(delta: float) -> void:
	if globType:
		position += velocity.normalized() * globSpeed * delta
		globSpeed -= globSpeed * 0.4 * delta
	else:
		#when globType == 0:
		velocity = (get_global_mouse_position() - position).normalized() * globSpeed
		look_at(get_global_mouse_position())
		position += velocity * delta


func _on_time_to_live_timeout() -> void:
	if not globType:
		queue_free()
	else:
		Pickupable = true


func _on_body_entered(body: Node2D) -> void:
	if body == parent:
		if Pickupable:
			parent.largeFired = false
			queue_free()
		return
	var isTilemap : bool = body is TileMap
	if globType:
		globSpeed = 0
		if not isTilemap:
			(body as Enemy).hit(3)
	else:
		if not isTilemap:
			(body as Enemy).hit(1)
		queue_free()
	#
	#if body is TileMap:
		#if globType:
			#globSpeed = 0
		#else:
			#queue_free()
	#else:
		#(body as Enemy).hit(1 + globType)
		#queue_free()
