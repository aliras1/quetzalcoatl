#ifndef CAFFDTO_H
#define CAFFDTO_H

#include "CIFFdto.h"
#include <vector>

class CAFFdto
{
public:
	CAFFdto(std::string path, std::vector<CIFFdto> ciffs) : path(path), ciffs{std::move(ciffs)} {}
	CAFFdto() {}
	std::string toJson();
private:
	std::string path;
	std::vector<CIFFdto> ciffs;
};
#endif
