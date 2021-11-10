#include "CAFFParser.h"
#include <fstream>
#include <cstring>
#include <iostream>

int main() {
	CAFFParser caffparser;

	fstream is("1.caff", ios::in | ios::binary);
	is.seekg(0, is.end);
	int length = is.tellg();
	is.seekg(0, is.beg);

	char* buffer = new char[length];

	std::cout << "Reading " << length << " characters... ";
	// read data as a block:
	is.read(buffer, length);

	if (is)
		std::cout << "all characters read successfully.";
	else {
		std::cout << "error: only " << is.gcount() << " could be read";
		throw;
	}
		
	is.close();
	
	caffparser.parser(buffer, length);
	delete[] buffer;
}
