extends Node

#BeginPlay
var Week : int
var Difficultie : int

#Score
var Score = 0
var AllScore = {
	"0": {
		"0": 0, "1": 0, "2": 0 }, 
	"1": {
		"0": 0, "1": 0, "2": 0 }
}

#Config
var config
var path_to_save = "user://GlobalData.cfg"
var section_name = "Score"

func load_data():
	config = ConfigFile.new()
	config.load(path_to_save)
	(AllScore["0"])["0"] = config.get_value(section_name, "00", 0)
	(AllScore["0"])["1"] = config.get_value(section_name, "01", 0)
	(AllScore["0"])["2"] = config.get_value(section_name, "02", 0)
	
	(AllScore["1"])["0"] = config.get_value(section_name, "10", 0)
	(AllScore["1"])["1"] = config.get_value(section_name, "11", 0)
	(AllScore["1"])["2"] = config.get_value(section_name, "12", 0)

func save_data():
	config.set_value(section_name, str(Week)+str(Difficultie), Score)
	config.save(path_to_save)

func _ready():
	load_data()
