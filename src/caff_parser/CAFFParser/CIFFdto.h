#ifndef CIFFDTO_H
#define CIFFDTO_H

#include <string>
#include <vector>
class CIFFdto
{
public:
	CIFFdto(std::string caption, std::vector<std::string> tags) : caption(caption), tags{ std::move(tags) }{}
	CIFFdto() {}
	std::string toJson();
private:
	std::string caption;
	std::vector<std::string> tags;
};
#endif // !CIFFDTO_H

