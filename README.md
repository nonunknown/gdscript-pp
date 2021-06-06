# Very Early Project

GDPP (GDScript++) Is a language that is a mix of GDScript and C++


## CHANGELOG

* Added actual conversion to CPP (Header files only)
* Updated base_hpp to be an actual hpp file, same for cpp
* Added var to headers (detect public and private, private ones are identified with a "_" before the var name)

## Description

* Converts GDScript to C++ (GDNATIVE)
* Can use pure c++ code inside gdpp
* Can use c++ built-in types as gdscript like code

## Updates

* Source Code detection system was rewritten for better readability
* Now instead of entire source code splitting the program reads line by line to translate into cpp
* Added Output tab
* Compile button renamed to Convert (Which makes more sense)
* Started auto completion system (can be tested when typing `func name(`
