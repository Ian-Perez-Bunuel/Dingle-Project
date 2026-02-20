extends Control


func set_showing(b: bool):
	visible = b
	
	if visible:
		open()
	else:
		close()
		

func open():
	print("Open")
		
func close():
	print("Close")
