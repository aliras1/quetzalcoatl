#include "ByteReader.h"
#include <vector>
using namespace std;
using namespace Orionark::Utility;

struct CAFF
{
	//meg ideel lehetne menteni dolgokat
	vector<CIFF> ciffs;
};

struct CIFF {
	int id;
	long long int contentSize;
	long long int width;
	long long int height;
	string caption;
	vector<string> tags;
	//meg ide amibe a kepet magat taroljuk 
};

class CAFFParser
{

public:


	CAFF parser(char* data, size_t size) {
		ByteReader bytereader(data, size);
		bytereader.SetEndian(LITTLE_ENDIAN);

		//Caff header beolvasása
		char CAFFheaderId = bytereader.ReadByte();
		if (CAFFheaderId != 1) {
			//return false;
		}
		long long int CAFFheaderLength = bytereader.ReadInt64();
		char c;
		for (int i = 0; i < 4;i++) {
			 c = bytereader.ReadByte();
		}
		long long int lengthOfTheHeader = bytereader.ReadInt64(); // ennke nem tudom milyen nevet kene adni
		long long int numberOfCIFF = bytereader.ReadInt64();
		//Caff credits block 
		char CAFFcreditsId = bytereader.ReadByte();
		long long int CAFFCreditsLength = bytereader.ReadInt64();
		short year = bytereader.ReadInt16();
		char month = bytereader.ReadByte();
		char day = bytereader.ReadByte();
		char hour = bytereader.ReadByte();
		char minute = bytereader.ReadByte();
		long long int lengthOfCreator = bytereader.ReadInt64();
		string creatorName = bytereader.ReadString(lengthOfCreator);
		//Caf animation header
		char CAFFAnimationId = bytereader.ReadByte();
		long long int CAFFAnimationHeaderLength = bytereader.ReadInt64();
		long long int duration = bytereader.ReadInt64();
		//Ciffek beolvasasa
		vector<CIFF> ciffs;
		for (int i = 0; i < numberOfCIFF; i++) {
			CIFF ciff;
			ciff.id = i;
			string ciff = bytereader.ReadString(4);
			long long int CiffHeaderSize = bytereader.ReadInt64();
			ciff.contentSize = bytereader.ReadInt64();
			ciff.width = bytereader.ReadInt64();
			ciff.height = bytereader.ReadInt64();
			if (ciff.contentSize != ciff.width * ciff.height * 3) {
				//	return false;
			}
			//caption
			char ch;
			string caption;
			int n = 0;
			while (ch != '\n') {
				ch = NULL;//ez nem biztos hogy kell
				ch = bytereader.ReadByte();
				n++;
				caption.push_back(ch);
			}
			ciff.caption = caption;
			//tags
			long long int tagsLength = CiffHeaderSize - 4 - 8 - 8 - 8 - 8 - n;
			int k = 0;
			vector<string> tags;
			string tag;
			for (int i = 0; i < tagsLength; i++) {
				tag.clear();
				while (ch != '\0') {
					ch = NULL;
					k++;
					ch= bytereader.ReadByte();
					tag.push_back(ch);
				}
				tags.push_back(tag);
				tagsLength -= k;
			}
			ciff.tags = tags;

			// at kell konvertalni valahogy a bytokat keppe


			ciffs.push_back(ciff);
		}
	}
};