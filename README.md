# Very Early Project

GDPP (GDScript++) Is a language that is a mix of GDScript and C++

## Description

* Converts GDScript to C++ (GDNATIVE)
* Can use pure c++ code inside gdpp
* Can use c++ built-in types as gdscript like code

## FAQ

**Q:** I want to test my code:

**A:** If you want to do so, be adviced that it is not ready for production yet.
Testing your code and giving me feedback will be awesome :D

* Clone this repo
* Open Godot
* Open the following scene: /addons/gdscript_pp/scenes/LanguageEditor.tscn
* Press F6
* Type your code and see the output!
* Report any issues

**Q:** I want to help into the development process.

**A:** You're very welcome, clone this repo, try to understand how things were done
and make your changes!

**Q:** This will be added as core?

**A:** Future is uncertain, I already talked with vnen, and only **GDNative Integration plugin** was confirmed to become core.

## CHANGELOG

* Added actual conversion to CPP (Header files only)
* Updated base_hpp to be an actual hpp file, same for cpp
* Added var to headers (detect public and private, private ones are identified with a "_" before the var name)

* Source Code detection system was rewritten for better readability
* Now instead of entire source code splitting the program reads line by line to translate into cpp
* Added Output tab
* Compile button renamed to Convert (Which makes more sense)