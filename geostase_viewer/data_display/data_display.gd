extends VBoxContainer

var data_row = preload("res://data_display_row/data_display_row.tscn")

func _files_dropped(files, screen):
	#delete all existing children
	var child_count = $VBoxContainer.get_child_count()
	
	for i in range(0, child_count):
		$VBoxContainer.get_child(i).queue_free()
		pass
	
	
	var file_dictionary = {}
	
	
	for file in files:
		var load_data = File.new()
		var extension = "gsd"
		var current_line = {}
		var current_file_dictionary = {}
		
		if file.get_extension() == extension:
			var file_path = file.split("\\")
			var file_name = file_path[file_path.size() - 1]
			
			current_file_dictionary
			load_data.open(file, File.READ)
			
			var i = 0
			
			while(!load_data.eof_reached() and i <= 6):
				current_line = load_data.get_line()
				current_file_dictionary[i] = current_line.strip_edges(true,true)
				
				i += 1
			
			file_dictionary[file_name] = current_file_dictionary
			
			load_data.close()
			
	generate_data(file_dictionary)
			
	return file_dictionary
			
func _ready():
	get_tree().connect("files_dropped", self, "_files_dropped")
	
	
func generate_data(dictionary):
	print(dictionary)
	for key in dictionary:
		var row_instance = data_row.instance()
		$VBoxContainer.add_child(row_instance)
		
		row_instance.get_node("file_name").set_text(key)
		row_instance.get_node("title_1").set_text(dictionary[key][5])
		row_instance.get_node("title_2").set_text(dictionary[key][6])
		pass
	pass
