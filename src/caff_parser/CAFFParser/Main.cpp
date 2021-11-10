#include "CAFFParser.h"

int main(int argc, char** argv) {
	if (argc > 1) {
		CAFFParser caffparser(argv[1]);
		caffparser.parse();
	}
	else {
		std::cout << "No CAFF file was specified to parse\n";
	}	
}
