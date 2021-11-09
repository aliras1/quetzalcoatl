#include "CAFFParser.h"
#include <fstream>
#include <cstring>

#define _CRT_SECURE_NO_WARNINGS

char* copy2(const char* orig) {
	char* res = new char[strlen(orig) + 1];
	strcpy_s(res,strlen(orig), orig);
	return res;
}


int main() {
	CAFFParser caffparser;
	char ch;
	fstream fin("1.caff", fstream::in);
	int length = 0;
	while (fin >> ch) {
		length++;
	}
	fin.close();
	char* data = new char[length];
	fin.open("1.caff", fstream::in);
	int i = 0;
	while (fin >> ch) {
		data[i++] = ch;
	}
	caffparser.parser(data);
}
