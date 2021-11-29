#include "JsonUtil.h"
#include <algorithm>
std::string json::betweenQMarks(std::string _string) {
	std::string ret = "";
	std::replace(_string.begin(), _string.end(), '\\', '/');
	ret.append("\"");
	ret.append(_string);
	ret.append("\"");
	return ret;
}
std::string json::betweenCurlyBrackets(std::string _string) {
	std::string ret = "";
	ret.append("{");
	ret.append(_string);
	ret.append("}");
	return ret;
}
std::string json::betweenSquaredBrackets(std::string _string) {
	_string.erase(std::remove(_string.begin(), _string.end(), '\n'), _string.end());
	std::string ret = "";
	ret.append("[");
	ret.append(_string);
	ret.append("]");
	return ret;
}
std::string json::toJsonArray(std::vector<std::string> vector){
	std::string ret = "";
	ret.append(betweenSquaredBrackets(concatWithSeparator(vector, ", ")));
	return ret;
}
std::string json::concatWithSeparator(std::vector<std::string> vector, std::string separator) {
	std::string ret = "";
	auto back = vector.back();
	vector.pop_back();
	for (auto element : vector) {
		ret.append(element);
		ret.append(separator);
	}
	ret.append(back);
	return ret;
}
std::string json::propertyWithName(std::string name, std::string value) {
	std::string ret = "";
	ret.append(betweenQMarks(name));
	ret.append(": ");
	ret.append(value);
	return ret;
}