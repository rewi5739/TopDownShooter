extends Area2D

var velocity: Vector2 = Vector2(0, 0)
var globSpeed: float = 0
var globType: int
var Pickupable: bool = false
var parent: CharacterBody2D
var damage: int = 1

func set_damage(power : int):
	damage = power

func fire(direction: Vector2, speed: float, type : int):
	globType = type
	globSpeed = speed
	if type:
		look_at(direction)
		scale = Vector2(2,2)
		velocity = direction
		$MainSprite.visible = false
		$RockSprite.visible = true
		$RockSprite.flip_v = (rotation < -PI/2 or rotation > PI/2)
	else:
		set_collision_mask_value(5, false)

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
			parent.large_fired = false
			queue_free()
		return
	var isTilemap : bool = body is TileMap
	if globType:
		globSpeed = 0
	else:
		queue_free()
	if not isTilemap:
		body.hit(damage)
	#
	#if body is TileMap:
		#if globType:
			#globSpeed = 0
		#else:
			#queue_free()
	#else:
		#(body as Enemy).hit(1 + globType)
		#queue_free()
