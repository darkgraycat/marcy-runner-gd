class_name JumpingComponent extends Component


@export var jumping: bool = false
@export var target_force: float = 300.0
@export var count: int = 1
var jump_in_progress: bool = false
var jumped_times: int = 0


func _physics_process(delta: float) -> void:
	handle_jumping(jumping, delta)


func handle_jumping(new_jumping: bool, _delta: float) -> void:
	if new_jumping && !jump_in_progress:
		jump_in_progress = true
		if parent.is_on_floor():
			parent.velocity.y = -target_force

	if !new_jumping:
		jump_in_progress = false
		if parent.velocity.y < 0:
			parent.velocity.y /= 2
