#include "CAFFParser.h"
#include "CIFFdto.h"
#include "CAFFdto.h"

int main(int argc, char** argv) {
	if (argc > 1) {
		bool justmetadata = false;
		if (argc > 2 && !strcmp(argv[2], "-m")) {
			justmetadata = true;
		}

		CAFFParser caffparser(argv[1], justmetadata);
		if (caffparser.tryParse()) {
			std::cout << caffparser.getMetadata().toJson() << '\n';
		}
		else {
			std::cout << "Invalid CAFF\n";
		}
	}
	else {
		std::cout << "No CAFF file was specified to parse\n";
	}
}