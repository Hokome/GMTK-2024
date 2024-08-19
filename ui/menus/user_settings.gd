class_name UserSettings extends Resource 

@export_range(0,100,1) var master_vol:float=100
@export_range(0,100,1) var music_vol:float=100
@export_range(0,100,1) var sfx_vol:float=100

func save()->void:
	ResourceSaver.save(self,"user://settings.tres")

static func load_or_create()->UserSettings:
	var res:UserSettings = load("user://settings.tres") as UserSettings
	if !res:
		res = UserSettings.new()
	return res
