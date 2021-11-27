#include "CIFFdto.h"
#include "JsonUtil.h"
#include <string>
#include <algorithm>
#include <iterator>
std::string CIFFdto::toJson() {
	std::string ret = "";

	std::vector<std::string> tagsListed;

	std::transform(tags.begin(), tags.end(), std::back_inserter(tagsListed), [](std::string s) -> std::string { return json::betweenQMarks(s); });

	std::vector<std::string> content{
		json::propertyWithName("caption", json::betweenQMarks(caption))
		,
		json::propertyWithName("tags", json::toJsonArray(tagsListed))
	};
	ret.append(
		json::betweenCurlyBrackets(
			json::concatWithSeparator(
				content, ", "
			)
		)
	);
	return ret;
}

