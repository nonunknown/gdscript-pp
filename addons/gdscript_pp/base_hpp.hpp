#pragma once

#include <Godot.hpp>

#ifndef %UNIQUE_NAME%
#define %UNIQUE_NAME%

namespace godot {

class %CLASS_NAME% : public %CLASS_EXTENDS% {
GODOT_CLASS(%CLASS_NAME%, %CLASS_EXTENDS%);

	public:
		static void _register_methods();

		%CLASS_NAME%();
		~%CLASS_NAME%();

	%PUBLIC_STUFF%

	private:
	%PRIVATE_STUFF%

};

}

#endif
