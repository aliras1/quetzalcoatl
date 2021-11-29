#include "CAFFdto.h"
#include "JsonUtil.h"
#include <algorithm>
#include <iterator>
std::string CAFFdto::toJson() {


	std::vector<std::string> ciffsAsJson;
	std::transform(ciffs.begin(), ciffs.end(), std::back_inserter(ciffsAsJson), [](CIFFdto ciff) -> std::string { return ciff.toJson(); });;
	return
		json::betweenCurlyBrackets(
			json::concatWithSeparator(
				std::vector<std::string> {
		json::propertyWithName("path", json::betweenQMarks(path)),
			json::propertyWithName("ciffs", json::toJsonArray(ciffsAsJson))
	}, ", ")
		);
}