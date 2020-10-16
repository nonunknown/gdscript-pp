extends Control

const keywords = ["const","var","func","extends","class","class_name","if", "else", "elif", "pass", "match","return"]
const types = ["int","float","bool","vector","byte","char","void"]
const symbols = [":","->","."]
const special = ["define"]

const placeholders:Dictionary = {
	"class_name":"%CLASS_NAME%",
	"class_extends":"%CLASS_EXTENDS%",
	"public_stuff":"%PUBLIC_STUFF%",
	"private_stuff":"%PRIVATE_STUFF%",
	"def":"%UNIQUE_NAME%"
}

const cpp_codes:Dictionary = {
	"function": "%TYPE% %CLASS_NAME%::%FUNC_NAME%(%ARGS%)\n{\n%FUNC_BODY%\n}\n",
	"variable": "%TYPE% %VAR_NAME%;",
	"default_var" : "%TYPE% %VAR_NAME% = %VALUE%;",
	"register_method": "register_method(\"%FUNC_NAME%\",&%CLASS_NAME%::%FUNC_NAME%);"
} 


onready var code_editor:TextEdit = $Main/VBoxContainer/TextEdit
# Called when the node enters the scene tree for the first time.
func _ready():
	
	for k in keywords:
		code_editor.add_keyword_color(k,Color.red)
	for t in types:
		code_editor.add_keyword_color(t,Color.pink)
	for s in symbols:
		code_editor.add_keyword_color(s,Color.wheat)
	for s in special:
		code_editor.add_keyword_color(s,Color.purple)
	code_editor.add_color_region("#","",Color.darkgray)
#	$TextEdit.add_color_region("DEF","",Color.purple)
#	$TextEdit.add_k
	pass # Replace with function body.

func compile():
	var hpp_source:String = ""
	var cpp_source:String = ""
	var cpp_keys = {}
	var public:String = ""
	var private:String = ""
	
	var f:File = File.new()
	f.open("res://addons/gdscript_pp/base_hpp.txt",File.READ)
	hpp_source = f.get_as_text()
	f.open("res://addons/gdscript_pp/base_cpp.txt",File.READ)
	cpp_source = f.get_as_text()
#	f.open("res://addons/gdscript_pp/cpp_keys.json",File.READ)
#	cpp_keys = parse_json(f.get_as_text())
	f.close()
	
	var sources = split(code_editor.text)
	var cname:String = ""
	
	print(sources)
	for i in range(sources.size()):
		var word = sources[i]
		match(word):
			"class_name":
				cname = sources[i+1]
				hpp_source = hpp_source.replace(placeholders["class_name"],cname)
			"extends":
				hpp_source = hpp_source.replace(placeholders["class_extends"],sources[i+1])
			"define":
				hpp_source = hpp_source.replace(placeholders["def"],sources[i+1])
			"var":
				var t = sources[i+1]
				t = sources[i+1].split(":")
				var name = t[0]
				var type = t[1]
				var value = null
				var result:String
				prints("I+2 is:" + sources[i+2])
				prints("I+3 is: " + sources[i+3])
				if sources[i+2] == "=": 
					value = sources[i+3]
					
				print("values: "+str(value))
				if value != null:
					result = cpp_codes.default_var
					result = result.replace("%VALUE%",value)
				else:
					result = cpp_codes.variable
					
				result = result.replace("%TYPE%",type)
				result = result.replace("%VAR_NAME%",name)
				if name.begins_with("_"):
					private += result+"\n\t\t"
				else:
					public += result+"\n\t\t"
				
#				print(cpp_keys)
				
				
#	print(sources)
	hpp_source = hpp_source.replace(placeholders.public_stuff,public)
	hpp_source = hpp_source.replace(placeholders.private_stuff,private)
	## CPP STUFF
	
	cpp_source = cpp_source.replace(placeholders["class_name"],cname)
	
	#------

	$Generated/HPP.text = hpp_source
	$Generated/CPP.text = cpp_source
	$Generated.visible = true
	pass

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			if $Generated.visible: $Generated.visible = false


func split(string:String):
	var result:Array = []
	result = string.split(" ",false)
	prints("berfore:",result)
	var i = 0
	while true:
		
		var word:String = result[i]
		
		if word.find("\n") > 0:
			var r = word.split("\n")
			print("Rn: " +str(r) )
			if !r.empty():
				var idx = i+1
				for v in range(r.size()):
					result.insert(idx+v,r[v])
				result.remove(i)
				i = -1 #reset
				pass
		if i+1 >= result.size(): break
		else: i += 1
	prints("after: ",result)
	
#	#clear spaces
#	for v in range(result.size()):
#		result[v] = result[v].replace(" ","@")
	
	return result

func _on_bt_compile_pressed():
	compile()
	pass # Replace with function body.

