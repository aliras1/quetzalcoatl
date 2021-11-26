#include <fstream>
#include <cstring>
#include <iostream>
#include <vector>

#include "ByteReader.h"
#include "Gif.h"
#include "CIFFdto.h"
#include "CAFFdto.h"

using namespace std;
using namespace Orionark::Utility;


class CAFFParser
{

public:
	CAFFParser(string filename) : filename(filename) {
		fstream is(filename, ios::in | ios::binary);
		is.seekg(0, is.end);
		int length = is.tellg();
		is.seekg(0, is.beg);

		char* buffer = new char[length];

		if(shallLog)
			std::cout << "Reading " << length << " characters... ";
		// read data as a block:
		is.read(buffer, length);
		
		if (is) {
			if (shallLog)
				std::cout << "all characters read successfully.";
		}
		else {
			if (shallLog)
				std::cout << "error: only " << is.gcount() << " could be read";
			throw;
		}

		is.close();

		this->bytereader = new ByteReader(buffer, length);
		this->bytereader->SetEndian(LITTLE_ENDIAN);
	}

	CAFFParser(string filename, bool shallLog) : CAFFParser(filename){
		setShallLog(shallLog);
	}

	~CAFFParser() {
		delete this->bytereader;
	}

	bool parse() {
		//Caff header beolvasasa
		char CAFFheaderId = this->bytereader->ReadByte();
		if (CAFFheaderId != 1) {
			//return false;
		}
		long long int CAFFheaderLength = this->bytereader->ReadInt64();
		string caff = this->bytereader->ReadString(4);
		long long int lengthOfTheHeader = this->bytereader->ReadInt64();
		long long int numberOfCIFF = this->bytereader->ReadInt64();
		//Caff credits block 
		char CAFFcreditsId = this->bytereader->ReadByte();
		long long int CAFFCreditsLength = this->bytereader->ReadInt64();
		short year = this->bytereader->ReadInt16();
		char month = this->bytereader->ReadByte();
		char day = this->bytereader->ReadByte();
		char hour = this->bytereader->ReadByte();
		char minute = this->bytereader->ReadByte();
		if (shallLog)
			std::cout << "year: " << (int)year << " month: " << (int)month << " day: " << (int)day << " hour: " << (int)hour << " min: " << (int)minute << "\n";
		long long int lengthOfCreator = this->bytereader->ReadInt64();
		string creatorName = this->bytereader->ReadString(lengthOfCreator);
		if (shallLog)
			std::cout << "creator: " << creatorName << "\n";

		GifWriter writer = {};
		string filename = "./" + this->filename + ".gif";		

		vector<CIFFdto> ciffs;
		//Ciffek beolvasasa
		for (int i = 0; i < numberOfCIFF; i++) {		
			//Caf animation header
			char CAFFAnimationId = this->bytereader->ReadByte();
			long long int CAFFAnimationHeaderLength = this->bytereader->ReadInt64();
			long long int duration = this->bytereader->ReadInt64();
			string ciff = this->bytereader->ReadString(4);
			long long int CiffHeaderSize = this->bytereader->ReadInt64();
			long long int contentSize = this->bytereader->ReadInt64();
			long long int width = this->bytereader->ReadInt64();
			long long int height = this->bytereader->ReadInt64();
			if (contentSize != width * height * 3)
				return false;

			if (i == 0) {
				GifBegin(&writer, filename.c_str(), width, height, duration / 100, 8, false);
			}
			if (shallLog)
				std::cout << "-------------\n" << "CIFF" << i << "\n";
			string caption = this->readCaption();
			if (shallLog)
				std::cout << "caption: " << caption << "\n";

			int tagsLength = CiffHeaderSize - 36; // header_size - everithing until caption
			tagsLength -= caption.length();
			vector<string> tags = this->readTags(tagsLength);
			if (shallLog) {
				std::cout << "tags: \n";
				for (size_t j = 0; j < tags.size(); j++)
				{
					cout << tags[j] << ", ";
				}
				cout << "\n";
			}
			

			uint8_t* image = new uint8_t[width * height * 4];

			for (size_t j = 0; j < contentSize / 3; j++)
			{
				char r = this->bytereader->ReadByte();
				char g = this->bytereader->ReadByte();
				char b = this->bytereader->ReadByte();

				this->setPixel(image, j, r, g, b);
			}

			GifWriteFrame(&writer, image, width, height, duration / 100, 8, false);

			ciffs.push_back(CIFFdto(caption, tags));

			delete[] image;
		}

		metadata = CAFFdto(ciffs);
		GifEnd(&writer);
	}

	void setShallLog(bool shallPrintLogToCout) {
		this->shallLog = shallPrintLogToCout;
	}

	CAFFdto getMetadata() {
		return metadata;
	}

private:
	ByteReader* bytereader;
	string filename;
	bool shallLog = false;
	CAFFdto metadata;

	string readCaption() {
		string caption = "";
		char c = 0;
		while (c != '\n') {
			c = this->bytereader->ReadByte();
			caption += c;
		}
		return caption;
	}

	vector<string> readTags(size_t tagsLength) {
		vector<string> tags;
		string tag = "";
		for (size_t i = 0; i < tagsLength; i++)
		{
			char c = this->bytereader->ReadByte();
			if (c != 0) {
				tag += c;
			}
			else {
				tags.push_back(string(tag));
				tag = "";
			}
		}
		return tags;
	}

	void setPixel(uint8_t* image, int i, uint8_t red, uint8_t grn, uint8_t blu)
	{
		uint8_t* pixel = &image[i * 4];
		pixel[0] = red;
		pixel[1] = blu;
		pixel[2] = grn;
		pixel[3] = 255;  // no alpha
	}
};