extends Node

var sections = {}

func _init(path):
	var file = File.new() 
	var err = file.open(path, File.READ)
	var current_section = ""
	if err != OK:
		return err
	while ! file.eof_reached():
		var line = file.get_line()
		line = line.strip_edges(true, true)
		if line.length() == 0:
			continue
		if line[0] == '#':
			continue
		if line[0] == '[':
			current_section = line.substr(1, line.length() - 2)
			sections[current_section] = {}
		else:
			var key = line.split('=')[0]
			var value = line.split('=')[1]
			sections[current_section][key] = value
	
	# Debug: show all values
	for key in sections:
		print(key)
		for key2 in sections[key]:
			print("\t" + key2 + " = " + sections[key][key2])
