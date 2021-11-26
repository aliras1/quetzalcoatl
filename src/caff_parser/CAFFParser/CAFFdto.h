#ifndef CAFFDTO_H
#define CAFFDTO_H

#include "CIFFdto.h"
#include <vector>

class CAFFdto
{
public:
	CAFFdto(std::vector<CIFFdto> ciffs) :ciffs{std::move(ciffs)} {}
	CAFFdto() {}
	std::string toJson();
private:
	std::vector<CIFFdto> ciffs;
};
#endif
