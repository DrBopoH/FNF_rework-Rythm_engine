extends Node2D

#Animations
var character_idle_tic = 0

var transition_tic = 0
var transition_now = false

func null_visibility():
	#Null visibility
	$Interface/Choice.visible = false
	$Interface/Choice/C.visible = false
	$Interface/Choice/D.visible = false
	$Interface/List.visible = false
	$Interface/LeftStick.visible = false
	$Interface/RightStick.visible = true
	$Interface/HitBox.visible = false
	$Interface/Nexting.visible = false

func _ready():
	OS.window_fullscreen = true
	
	#loading
	transition_now = true
	transition_tic = 70
	$Interface/Transition.position.y = 400
	
	null_visibility()

func _physics_process(delta):
	print(character_idle_tic)
	character_idle_tic += 1
	if character_idle_tic < 60:
		$BoyFrend.play("BF_stage_Uidle")
	elif character_idle_tic == 60:
		$BoyFrend.play("BF_stage_Aidle")
	elif character_idle_tic == 90:
		character_idle_tic = 0
		
	
	if transition_now:
		$Interface/Transition.position.y +=20
		transition_tic +=1
		if transition_tic >= 140:
			transition_tic = 0
			transition_now = false
	else:
		$Interface/Transition.position.y = -1020
