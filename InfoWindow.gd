extends Control

var fps = 0
var fps_procent = 0.0
var fr = 0.0
var fg = 0.0
var load_procent = 0.0
var lr = 0.0
var lg = 0.0
var ram = 0
var ram_procent = 0.0
var rr = 0.0
var rg = 0.0

# warning-ignore:unused_argument
func _physics_process(delta):
	fps = Engine.get_frames_per_second()
	ram = float(OS.get_static_memory_usage()+OS.get_dynamic_memory_usage())/1024/1024
	
	fps_procent = fps/120
	if fps_procent > 1.0:
		fps_procent = 1.0
	if fps_procent <= 0.5:
		fr = 1.0
		fg = fps_procent * 2.0
	else:
		fr = 1.0 - (fps_procent - 0.5) * 2.0
		fg = 1.0
	
	load_procent = (Performance.get_monitor(Performance.TIME_PHYSICS_PROCESS)*1000000)/16666
	if load_procent > 1.0:
		load_procent = 1.0
	if load_procent <= 0.5:
		lr = ram_procent * 2.0
		lg = 1.0
	else:
		lr = 1.0
		lg = 1.0 - (load_procent - 0.5) * 2.0
	
	ram_procent = ram/550
	if ram_procent > 1.0:
		ram_procent = 1.0
	if ram_procent <= 0.5:
		rr = ram_procent * 2.0
		rg = 1.0
	else:
		rr = 1.0
		rg = 1.0 - (ram_procent - 0.5) * 2.0
	
	$RamLabel.text = "RAM: "+str(round(ram * 1000)/1000)+"/mb"
	$RamLabel.modulate = Color(rr, rg, 0, 1)
	$FpsLabel.text = "FPS: "+str(fps)
	$FpsLabel.modulate = Color(fr, fg, 0, 1)
	$LoadLabel.text = "Load: "+str(round(load_procent * 100))+"%"
	$LoadLabel.modulate = Color(lr, lg, 0, 1)
