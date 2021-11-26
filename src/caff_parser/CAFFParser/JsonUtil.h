#ifndef JSONUTIL_H
#define JSONUTIL_H

#include <string>
#include <vector>
namespace json{
	std::string betweenQMarks(std::string _string);
	std::string betweenCurlyBrackets(std::string _string);
	std::string betweenSquaredBrackets(std::string _string);
	std::string toJsonArray(std::vector<std::string> vector);
	std::string propertyWithName(std::string name, std::string value);
	std::string concatWithSeparator(std::vector<std::string> vector, std::string separator);
}
#endif // !JSONUTIL_H

