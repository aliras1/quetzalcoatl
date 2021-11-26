#include "CAFFdto.h"
#include "JsonUtil.h"
#include <algorithm>
#include <iterator>
std::string CAFFdto::toJson() {
	std::string ret = "";

	std::vector<std::string> ciffsAsJson;
	std::transform(ciffs.begin(), ciffs.end(), std::back_inserter(ciffsAsJson), [](CIFFdto ciff) -> std::string { return ciff.toJson(); });
	ret.append(
		json::betweenCurlyBrackets(
			json::propertyWithName("ciffs", json::toJsonArray(ciffsAsJson))
		)
	);
	return ret;
}