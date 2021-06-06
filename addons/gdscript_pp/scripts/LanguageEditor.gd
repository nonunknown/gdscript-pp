extends Control

const keywords = ["const","var","func","extends","class_name","define","enum","signal","export","onready","unsafe"]
const others = ["if", "else", "elif", "pass", "match","return"]
const types = ["int","float","bool","vector","void"]
const cpp_types = ["char"]
const symbols = [":","->","."]

const placeholders:Dictionary = {
	"cname":"%CLASS_NAME%",
	"cextends":"%CLASS_EXTENDS%",
	"public_stuff":"%PUBLIC_STUFF%",
	"private_stuff":"%PRIVATE_STUFF%",
	"def":"%UNIQUE_NAME%",
}

const cpp_codes:Dictionary = {
	"function": "%TYPE% %CLASS_NAME%::%FUNC_NAME%(%ARGS%)\n{\n%FUNC_BODY%\n}\n",
	"variable": "%TYPE% %VAR_NAME%;",
	"default_var" : "%TYPE% %VAR_NAME% = %VALUE%;",
	"register_method": "register_method(\"%FUNC_NAME%\",&%CLASS_NAME%::%FUNC_NAME%);"
} 

const hpp_codes:Dictionary = {
	"method": "%TYPE% %NAME%(%ARGS%);\n\t\t"
}


onready var code_editor:TextEdit = $Main/VBoxContainer/TextEdit
onready var output:TextEdit = $Main/VBoxContainer/te_output
# Called when the node enters the scene tree for the first time.
func _ready():
	
	for k in keywords:
		code_editor.add_keyword_color(k,Color.red)
	for t in types:
		code_editor.add_keyword_color(t,Color.rebeccapurple)
	for s in symbols:
		code_editor.add_keyword_color(s,Color.wheat)
	for o in others:
		code_editor.add_keyword_color(o,Color.aqua)
	for c in cpp_types:
		code_editor.add_keyword_color(c,Color.yellowgreen)
#	for s in special:
#		code_editor.add_keyword_color(s,Color.purple)
#	code_editor.add_color_region("#","\n",Color.black)
#	code_editor.add_color_region('"','"',Color.yellow)
#	$TextEdit.add_color_region("DEF","",Color.purple)
#	$TextEdit.add_k
	pass # Replace with function body.

func compile():
	output.send_message("Starting to compile...")
	lint_code()
	generate_header()
	generate_cpp()
	save_generated_files()
	show_stuff()
	

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			if $Generated.visible: $Generated.visible = false

func lint_code():
	output.send_message("TODO: Lint Code")
	
	
	
	pass

var hpp_source:String = ""
var public:String = ""
var private:String = ""
func generate_header():
	output.send_message("Starting Header Generation:")
	
	output.send_message("\t defining variables")
	public = ""
	private = ""
	hpp_source = ""
	output.send_message("\t Opening Base HPP File")
	var f:File = File.new()
	var err = f.open("res://addons/gdscript_pp/base_hpp.hpp",File.READ)
	if err != OK:
		output.send_error("\t Error Opening HPP Base File")
		return
	else:
		hpp_source = f.get_as_text()
		output.send_message("\t Opened OK!")

	f.close()
	var function_index:int = -1
	output.send_message("Reading your GDPP Source code")
	for i in range(code_editor.get_line_count()):
		var line:String = code_editor.get_line(i)
#		output.send_error("@%s@" % line)
#		if line.begins_with("\t"):
#			var previous_line:String = code_editor.get_line(i-1)
#			output.send_message("Previous line: %s" % previous_line)
#			var previous_is_func:bool = ("func" in previous_line)
#			output.send_message("Previous line is function: %s" % str(previous_is_func) )
		if line.empty() or line.begins_with("#") or line.begins_with("\t"):
			output.send_warning("Empty Line found at: %d" % (i+1))
			continue
			
		
		var source = line.split(" ",false)
		var found:bool = false
		output.send_message("reading: %s" % str(source))
		for word in keywords:
			if source[0] == word:
				output.send_warning("at line %d: found keyword: %s" % [i+1, word])
				call("_eat_%s" % word, source)
				found = true
		if !found:
			output.send_error("error at line %d: keyword is expected and nothing has been found." % (i+1) )
			return
		print(str(source))
		output.send_warning(str(source))
	hpp_source = hpp_source.replace(placeholders.public_stuff,public)
	hpp_source = hpp_source.replace(placeholders.private_stuff,private)
	$Generated/HPP.text = hpp_source
	
	


func _eat_var(data:Array) -> void:
	output.send_message("Eating Var %s" % str(data))
	var name:String = data[1].split(":")[0]
	var type:String = data[1].split(":")[1]
	if name.begins_with("_"):
		private += "\t%s %s;\n\t" % [type,name]
	else:
		public += "\t%s %s;\n\t" % [type,name]
	
	pass

func _eat_func(data:Array) -> void:
	output.send_message("Eating func %s" % str(data))
	
	pass

func _eat_class_name(data:Array) -> void:
	output.send_message("Eating classname %s" % str(data))
	
	hpp_source = hpp_source.replace(placeholders.cname,data[1])
	
	
	
	pass

func _eat_extends(data:Array) -> void:
	output.send_message("Eating extends %s" % str(data))
	hpp_source = hpp_source.replace(placeholders.cextends,data[1])
	
	pass

func _eat_define(data:Array) -> void:
	output.send_message("Eating define %s" % str(data))
	
	hpp_source = hpp_source.replace(placeholders.def,data[1])
	output.send_message("Define: %s" % data[0])
	pass

func _eat_enum(data:Array) -> void:
	output.send_message("Eating enum %s" % str(data))
	
	pass

func _eat_signal(data:Array) -> void:
	output.send_message("Eating signal %s" % str(data))
	pass

func _eat_export(data:Array) -> void:
	output.send_message("Eating export %s" % str(data))
	pass
	
func _eat_onready(data:Array) -> void:
	output.send_message("Eating onready %s" % str(data))
	pass

func _eat_const(data:Array) -> void:
	output.send_message("Eating const %s" % str(data))
	pass

func _eat_unsafe(data:Array) -> void:
	output.send_message("Eating unsafe %s" % str(data))
	pass

func generate_cpp():
	pass
	
func save_generated_files():
	pass

func show_stuff():
	$Generated.visible = true
	pass

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

func _get_clean_word(string:String) -> String:
	var regex:RegEx = RegEx.new()
	regex.compile("\\w+")
	var m:RegExMatch = regex.search(string)
	return m.get_string()
	pass



func _on_bt_output_pressed():
	$Main/VBoxContainer/te_output.visible = !$Main/VBoxContainer/te_output.visible
	pass # Replace with function body.


func _on_bt_convert_pressed():
	$Main/VBoxContainer/te_output.text = ""
	$Main/VBoxContainer/te_output.show()
	compile()
