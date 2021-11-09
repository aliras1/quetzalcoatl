#include "ByteReader.h"
using namespace std;
using namespace Orionark::Utility;


class CAFFParser
{

public:


	bool parser(char* data) {
		ByteReader bytereader(data);
		bytereader.SetEndian(LITTLE_ENDIAN);
		//Caff header beolvasása
		char CAFFheaderId = bytereader.ReadByte();
		if (CAFFheaderId != 1) {
			return false;
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
		for (int i = 0; i < numberOfCIFF; i++) {
			string ciff = bytereader.ReadString(4);
			long long int CiffHeaderSize = bytereader.ReadInt64();
			long long int contentSize = bytereader.ReadInt64();
			long long int width = bytereader.ReadInt64();
			long long int height = bytereader.ReadInt64();
			if (contentSize != width * height * 3)
				return false;
			//itt meg kell csinalni meg a captiont 
			//meg kell csinalni meg a tagseket 
			// at kell konvertalni valahogy a bytokat keppe
		}
	}
};