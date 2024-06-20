extends Node2D

#Loading
var load_tic = 1
var begin_game = false
var storymode_begin_play = true

#Interface inputs
var A = false
var B = false

#Current
var menumod = 0
var choicemod = 0
var maxmodes = 2

#Difficulties
var Arrow_textures = []
var Dif_textures = []
var Difficultie = 0
var maxDiff = 2

#Animations
var transition_tic = 0
var transition_now = false

var choicemod_select_anim = false
var choicemod_select_anim_tic = 0
var choicevisibly = true

#Interface smooth
var interface_tp = 0
var interface_tp_delta = 0
var interface_tp_percent = 0
var interface_smooth_now = false
var interface_smooth_speed = 1
var interface_smooth_capacitys = [1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 4, 3, 3, 3, 2, 2, 2, 1, 1]
var interface_smooth_capacity_index = 0

func null_visibility():
	#Null visibility
	$AnimBackground.visible = false
	$Choicemod0.visible = false
	$Choicemod1.visible = false
	$Choicemod2.visible = false
	$Interface/Choice.visible = false
	$Interface/Choice/C.visible = false
	$Interface/Choice/D.visible = false
	$Interface/List.visible = false
	$Interface/LeftStick.visible = false
	$Interface/RightStick.visible = false
	$Interface/HitBox.visible = false
	$Interface/GirlfrendDance.visible = false
	$Interface/Flash.visible = false
	$Interface/Flash.play("Null")
	$Credits.visible = false
	$Interface/Logos.visible = false
	$Interface/Difficulties.visible = false
	$Interface/Score.visible = false
	$Interface/Cpw_BF.visible = false

func _ready():
	OS.window_fullscreen = true
	#Difficulties
	Arrow_textures.append(preload("res://Menu/Choices/StoryMode/UI_assets/Difficulties/Arrows/uArrow.png"))
	Arrow_textures.append(preload("res://Menu/Choices/StoryMode/UI_assets/Difficulties/Arrows/aArrow.png"))
	
	Dif_textures.append(preload("res://Menu/Choices/StoryMode/UI_assets/Difficulties/easy.png"))
	Dif_textures.append(preload("res://Menu/Choices/StoryMode/UI_assets/Difficulties/normal.png"))
	Dif_textures.append(preload("res://Menu/Choices/StoryMode/UI_assets/Difficulties/hard.png"))
	
	#Interface
	#Nexting
# warning-ignore:return_value_discarded
	$Interface/Nexting/Next.connect("pressed", self, "button_NextingNext_pressed")
	
	#List
# warning-ignore:return_value_discarded
	$Interface/List/Down.connect("pressed", self, "button_ListDown_pressed")
# warning-ignore:return_value_discarded
	$Interface/List/Up.connect("pressed", self, "button_ListUp_pressed")
	
	#Choice
# warning-ignore:return_value_discarded
	$Interface/Choice/A.connect("pressed", self, "button_ChoiceA_pressed")
# warning-ignore:return_value_discarded
	$Interface/Choice/B.connect("pressed", self, "button_ChoiceB_pressed")
# warning-ignore:return_value_discarded
	$Interface/Choice/C.connect("pressed", self, "button_ChoiceC_pressed")
# warning-ignore:return_value_discarded
	$Interface/Choice/D.connect("pressed", self, "button_ChoiceD_pressed")
	
	
	#RightStick
	
	
	#LeftStick
# warning-ignore:return_value_discarded
	$Interface/LeftStick/Down.connect("pressed", self, "button_ListDown_pressed")
# warning-ignore:return_value_discarded
	$Interface/LeftStick/Up.connect("pressed", self, "button_ListUp_pressed")
# warning-ignore:return_value_discarded
	$Interface/LeftStick/Right.connect("pressed", self, "button_LeftstickRight_pressed")
	$Interface/LeftStick/Right.connect("button_up", self, "button_LeftstickRight_up")
	$Interface/LeftStick/Right.connect("button_down", self, "button_LeftstickRight_down")
# warning-ignore:return_value_discarded
	$Interface/LeftStick/Left.connect("pressed", self, "button_LeftstickLeft_pressed")
	$Interface/LeftStick/Left.connect("button_up", self, "button_LeftstickLeft_up")
	$Interface/LeftStick/Left.connect("button_down", self, "button_LeftstickLeft_down")
	
	null_visibility()


#Interface
#Nexting
func button_NextingNext_pressed():
	if load_tic != 0:
		if load_tic > 300:
			if load_tic < 870:
				load_tic = 870
			else:
				if !transition_now:
					transition_now = true
					menumod = 0
					$Choice_confirm.play()
					$Credits.play("Apresstobegin")
					load_tic = 871

#List
func button_ListDown_pressed():
	if !choicemod_select_anim and !transition_now:
		$Choice_scroll.play()
		choicemod += 1
		if choicemod > maxmodes:
			choicemod = 0
func button_ListUp_pressed():
	if !choicemod_select_anim and !transition_now:
		$Choice_scroll.play()
		choicemod -= 1
		if choicemod < 0:
			choicemod = maxmodes

#Choice
func button_ChoiceA_pressed():
	if !choicemod_select_anim and !transition_now:
		if menumod < 2:
			$Choice_confirm.play()
		A = true
		choicemod_select_anim = true
func button_ChoiceB_pressed():
	if !choicemod_select_anim and !transition_now:
		$Choice_cancel.play()
		B = true
		choicemod_select_anim = true
		if menumod == 0:
			menumod = -1
func button_ChoiceC_pressed():
	if !choicemod_select_anim:
		pass
func button_ChoiceD_pressed():
	if !choicemod_select_anim:
		pass

#RightStick


#LeftStick
func button_LeftstickRight_up():
	$Interface/Difficulties/Difficul_right.texture = Arrow_textures[0]
func button_LeftstickRight_down():
	$Interface/Difficulties/Difficul_right.texture = Arrow_textures[1]
func button_LeftstickRight_pressed():
	Difficultie += 1
	if Difficultie > 2:
		Difficultie = 0

func button_LeftstickLeft_up():
	$Interface/Difficulties/Difficul_left.texture = Arrow_textures[0]
func button_LeftstickLeft_down():
	$Interface/Difficulties/Difficul_left.texture = Arrow_textures[1]
func button_LeftstickLeft_pressed():
	Difficultie -= 1
	if Difficultie < 0:
		Difficultie = 2

# warning-ignore:unused_argument
func _physics_process(delta):
	#Loading
	if load_tic != 0:
		if load_tic >= 870:
			$Interface/Flash.play("Flash")
			$Interface/Flash.visible = true
			$Interface/GirlfrendDance.position = Vector2(900, 290)
			$Interface/GirlfrendDance.scale = Vector2(0.8, 0.8)
			$Interface/GirlfrendDance.play("GirlfrendDance")
			$Interface/GirlfrendDance.visible = true
			$Credits.position = Vector2(643, 740)
			if load_tic <= 870:
				$Credits.play("Upresstobegin")
			$Credits.visible = true
			$Interface/Logos.position = Vector2(386, 193)
			$Interface/Logos.scale = Vector2(0.8, 0.8)
			$Interface/Logos.play("FNFlogo")
			$Interface/Logos.visible = true
		elif load_tic >= 850:
			$Credits.play("FRIDAY NIGHT FUNKIN")
		elif load_tic >= 800:
			$Credits.play("FRIDAY NIGHT")
		elif load_tic >= 750:
			$Credits.play("FRIDAY")
			$Credits.visible = true
		elif load_tic >= 720:
			$Credits.visible = false
		elif load_tic >= 690:
			$Credits.play("CAWCAW")
		elif load_tic >= 600:
			$Credits.position = Vector2(643, 395)
			$Credits.play("CAW")
			$Credits.visible = true
		elif load_tic >= 570:
			$Credits.visible = false
			$Interface/Logos.visible = false
		elif load_tic >= 540:
			$Interface/Logos.position = Vector2(643, 450)
			$Interface/Logos.play("Newgrounds")
			$Interface/Logos.visible = true
		elif load_tic >= 450:
			$Credits.position = Vector2(643, 335)
			$Credits.play("NOT ASSOCIATED WITH")
			$Credits.visible = true
		elif load_tic >= 420:
			$Credits.visible = false
		elif load_tic >= 390:
			$Credits.play("RHYTHM ENGINE BY DR BOPOH")
		elif load_tic >= 300:
			$Credits.position = Vector2(643, 395)
			$Credits.play("RHYTHM ENGINE BY")
			$Credits.visible = true
			if !$MenuMusic.playing:
				$MenuMusic.play()
		if load_tic != 870:
			load_tic += 1
		else:
			$Interface/Transition.position.y = -1020
		if load_tic == 901:
			load_tic = 0
	
	#MainMenu
	else:
		#Menus
		if menumod == 0:
			maxmodes = 2
		elif menumod == 1:
			maxmodes = 1
			if Difficultie ==1:
				$Interface/Difficulties/Difficultie.rect_position.x = 935
			else:
				$Interface/Difficulties/Difficultie.rect_position.x = 975
			$Interface/Difficulties/Difficultie.texture = Dif_textures[Difficultie]
		elif menumod == 2:
			maxmodes = 2
		elif menumod == 3:
			maxmodes = 2
		
		#Choices
		if choicemod == 0:
			if menumod == 0:
				interface_tp = 30
				$Choicemod0.play("AStoryMode")
				$Choicemod1.play("UFreePlay")
				$Choicemod2.play("UOptions")
			elif menumod == 1:
				if !choicemod_select_anim:
					$Interface/GirlfrendDance.visible = true
					$Interface/Logos.play("WeekStage")
					$Choicemod0.modulate = Color(1, 1, 1, 1)
					$Choicemod0.scale = Vector2(1, 1)
					$Choicemod1.modulate = Color(0.58, 0.58, 0.58, 1)
					$Choicemod1.scale = Vector2(0.8, 0.8)
				interface_tp = 63
		elif choicemod == 1:
			if menumod == 0:
				interface_tp = 50
				$Choicemod0.play("UStoryMode")
				$Choicemod1.play("AFreePlay")
				$Choicemod2.play("UOptions")
			if menumod == 1:
				if !choicemod_select_anim:
					$Interface/GirlfrendDance.visible = false
					$Interface/Logos.play("WeekTabi")
					$Choicemod0.modulate = Color(0.58, 0.58, 0.58, 1)
					$Choicemod0.scale = Vector2(0.8, 0.8)
					$Choicemod1.modulate = Color(1, 1, 1, 1)
					$Choicemod1.scale = Vector2(1, 1)
				interface_tp = 177
		elif choicemod == 2:
			if menumod == 0:
				interface_tp = 70
				$Choicemod0.play("UStoryMode")
				$Choicemod1.play("UFreePlay")
				$Choicemod2.play("AOptions")
		
		#Transition
		if transition_now:
			$Interface/Transition.position.y +=20
			if transition_tic >= 70:
				if menumod == -1:
					$Interface/Nexting/Next.visible = true
				elif menumod == 0:
					$AnimBackground.play("TMainMenu")
					if transition_tic == 80 and $Interface/Nexting/Next.visible:
						$Choice_scroll.play()
						$Interface/Nexting/Next.visible = false
					$Interface/GirlfrendDance.visible = false
					$Credits.visible = false
					$Interface/Logos.visible = false
					$Interface/LeftStick.visible = false
					$Interface/Difficulties.visible = false
					$Interface/Score.visible = false
					$Interface/Cpw_BF.visible = false
					$AnimBackground.visible = true
					interface_smooth_speed = 1.5
					$Choicemod0.position = Vector2(643, 165)
					$Choicemod0.scale = Vector2(1, 1)
					$Choicemod0.modulate = Color(1, 1, 1, 1)
					$Choicemod1.position = Vector2(643, 313)
					$Choicemod1.scale = Vector2(1, 1)
					$Choicemod1.modulate = Color(1, 1, 1, 1)
					$Choicemod0.visible = true
					$Choicemod1.visible = true
					$Choicemod2.visible = true
					$Interface/Choice.visible = true
					$Interface/List.visible = true
				elif menumod == 1:
					if begin_game:
						GlobalData.Difficultie = Difficultie
						GlobalData.Week = choicemod
# warning-ignore:return_value_discarded
						get_tree().change_scene("res://Game/Game.tscn")
					$AnimBackground.visible = false
					$Interface/List.visible = false
					$Interface/GirlfrendDance.position = Vector2(965, 195)
					$Interface/GirlfrendDance.scale = Vector2(0.45, 0.45)
					$Interface/GirlfrendDance.play("Cpw_GF")
					$Interface/GirlfrendDance.visible = true
					$Interface/LeftStick.visible = true
					$Interface/Logos.position = Vector2(643, 190)
					$Interface/Logos.scale = Vector2(0.94, 0.94)
					$Interface/Logos.play("WeekStage")
					$Interface/Logos.visible = true
					interface_smooth_speed = 2.5
					$Choicemod0.position = Vector2(643, 513)
					$Choicemod1.position = Vector2(643, 623)
					$Choicemod0.play("Week_Tutorial")
					$Choicemod1.play("Week_Chapter1")
					$Choicemod0.visible = true
					$Choicemod1.visible = true
					$Interface/Difficulties.visible = true
					$Interface/Score.visible = true
					$Interface/Cpw_BF.play("Cpw_BF")
					$Interface/Cpw_BF.visible = true
					
				elif menumod == 2:
					$AnimBackground.play("TFreeplayMenu")
				elif menumod == 3:
					$AnimBackground.play("TOptionsMenu")
			transition_tic +=1
			if transition_tic >= 140:
				if menumod == -1:
					load_tic = 851
				transition_tic = 0
				transition_now = false
		else:
			$Interface/Transition.position.y = -1020
		
		if choicemod_select_anim:
			if B:
				if choicemod_select_anim_tic <= 10:
					transition_now = true
			
			if choicemod_select_anim_tic >= 120:
				choicemod_select_anim_tic = -1
				A = false
				B = false
				choicemod_select_anim = false
			elif choicemod_select_anim_tic >= 60:
				if A:
					if choicemod_select_anim_tic == 60:
						if menumod == 1:
							begin_game = true
							transition_now = true
						elif menumod == 0:
							menumod = choicemod+1
							choicemod = 0
							$AnimBackground.play("TMainMenu")
							$Choicemod0.visible = false
							$Choicemod1.visible = false
							$Choicemod2.visible = false
							transition_now = true
				elif B:
					if menumod == 1:
						$Interface.position.y = 160
					if choicemod_select_anim_tic == 60:
						if menumod != -1:
							choicemod = menumod-1
							menumod = 0
							$Choicemod0.visible = true
							$Choicemod1.visible = true
							$Choicemod2.visible = true
						else:
							choicemod = 0
							null_visibility()
							$Interface.position.y = 140
			else:
				if A:
					if menumod == 0:
						if choicemod_select_anim_tic%5 == 0:
							if choicemod == 0:
								$Choicemod0.visible = choicevisibly
								choicevisibly = !choicevisibly
								$AnimBackground.play("TStoryMenu_begin")
							elif choicemod == 1:
								$Choicemod1.visible = choicevisibly
								choicevisibly = !choicevisibly
								$AnimBackground.play("TFreeplayMenu_begin")
							elif choicemod == 2:
								$Choicemod2.visible = choicevisibly
								choicevisibly = !choicevisibly
								$AnimBackground.play("TOptionsMenu_begin")
					elif menumod == 1:
						$Interface/Cpw_BF.play("Cpw_BF_continue")
						if choicemod_select_anim_tic%5 == 0:
							if choicemod == 0:
								if storymode_begin_play:
									$Choicemod0.modulate = Color(0, 1, 1, 1)
								else:
									$Choicemod0.modulate = Color(1, 1, 1, 1)
								storymode_begin_play = !storymode_begin_play
								$AnimBackground.play("TStoryMenu_begin")
							elif choicemod == 1:
								if storymode_begin_play:
									$Choicemod1.modulate = Color(0, 1, 1, 1)
								else:
									$Choicemod1.modulate = Color(1, 1, 1, 1)
								storymode_begin_play = !storymode_begin_play
			choicemod_select_anim_tic += 1
		
		#Interface smooth animation
		if menumod >= 0:
			if transition_tic>=80 or transition_tic==0:
				if $Interface.position.y != interface_tp:
					if !interface_smooth_now:
						interface_tp_delta = interface_tp-$Interface.position.y
					interface_smooth_now = true
					interface_tp_percent = int(abs((interface_tp-$Interface.position.y)*100/interface_tp_delta))
					if interface_tp_percent % 5 == 0:
						interface_smooth_capacity_index = interface_tp_percent/5-1
						if interface_smooth_capacity_index < 0:
							interface_tp_percent = 0
						elif interface_smooth_capacity_index >= 20:
							interface_smooth_capacity_index = 19
					
					if interface_tp-$Interface.position.y > 2:
						$Interface.position.y += interface_smooth_capacitys[interface_smooth_capacity_index]*interface_smooth_speed
					elif interface_tp-$Interface.position.y < -2:
						$Interface.position.y -= interface_smooth_capacitys[interface_smooth_capacity_index]*interface_smooth_speed
				else:
					interface_smooth_now = false
					interface_tp_delta = 0
					interface_tp_percent = 0
