#include "CAFFParser.h"
#include "CIFFdto.h"
#include "CAFFdto.h"

int main(int argc, char** argv) {
	if (argc > 1) {
		CAFFParser caffparser(argv[1]);
		caffparser.parse();
		std::cout << caffparser.getMetadata().toJson();
	}
	else {
		std::cout << "No CAFF file was specified to parse\n";
	}
}