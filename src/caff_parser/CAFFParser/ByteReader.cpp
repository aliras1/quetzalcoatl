#include <iostream>

#include "ByteReader.h"

using namespace Orionark::Utility;

ByteReader::ByteReader(char* data, size_t size)
    : data(data),
    size(size),
    pointer(0)
{
    if (O32_HOST_ORDER == O32_LITTLE_ENDIAN)
    {
        endian = MY_LITTLE_ENDIAN;
    }
    else if (O32_HOST_ORDER == O32_BIG_ENDIAN)
    {
        endian = MY_BIG_ENDIAN;
    }
    else
    {
        endian = MY_POP_ENDIAN;
    }
}

ByteReader::~ByteReader()
{

}

void ByteReader::SetEndian(ByteEndianness end)
{
    endian = end;
}

long unsigned int ByteReader::Tell()
{
    return pointer;
}

void ByteReader::Seek(long unsigned int target)
{
    pointer = target;
}

char ByteReader::ReadByte()
{
    return ReadAny<char>();
}

float ByteReader::ReadSingle()
{
    return ReadAny<float>();
}

double ByteReader::ReadDouble()
{
    return ReadAny<double>();
}

short ByteReader::ReadInt16()
{
    return ReadAny<short>();
}

unsigned short ByteReader::ReadUInt16()
{
    return ReadAny<unsigned short>();
}

int ByteReader::ReadInt32()
{
    return ReadAny<int>();
}

unsigned int ByteReader::ReadUInt32()
{
    return ReadAny<unsigned int>();
}

long long int ByteReader::ReadInt64()
{
    return ReadAny<long long int>();
}

long long unsigned int ByteReader::ReadUInt64()
{
    return ReadAny<long long unsigned int>();
}

std::string ByteReader::ReadString(unsigned int length)
{
    std::string ret((char*)(data + pointer), length);
    pointer += length;
    return ret;
}

template<class T> T ByteReader::ReadAny()
{
    size_t size_of_t = sizeof(T);

    if (pointer + size_of_t > this->size) {
        std::cout << "reading out of bound\n";
        exit(1);
    }

    T ret;
    char* dst = (char*)&ret;
    char* src = (char*)&(data[pointer]);
    
    StoreBytes(src, dst, size_of_t);
    pointer += size_of_t;
    return ret;
}

void ByteReader::StoreBytes(
    char* src,
    char* dst,
    size_t size
)
{
    for (size_t i = 0; i < size; i++)
    {
        if (O32_HOST_ORDER == O32_LITTLE_ENDIAN)
        {
            if (endian ==MY_LITTLE_ENDIAN) {
                dst[i] = src[i];
            }                
            else if (endian == MY_BIG_ENDIAN)
                dst[i] = src[(size - i - 1)];
            else if (endian == MY_POP_ENDIAN)
                dst[i] = src[(i % 2 == 0 ? (size - i - 2) : (size - i))];
        }
        else if (O32_HOST_ORDER == O32_BIG_ENDIAN)
        {
            if (endian == MY_BIG_ENDIAN)
                dst[i] = src[i];
            else if (endian == MY_LITTLE_ENDIAN)
                dst[i] = src[(size - i - 1)];
            else if (endian == MY_POP_ENDIAN)
                dst[i] = src[(i % 2 == 0 ? (i + 1) : (i - 1))];
        }
        else
        {
            if (endian == MY_POP_ENDIAN)
                dst[i] = src[i];
            else if (endian == MY_LITTLE_ENDIAN)
                dst[i] = src[(i % 2 == 0 ? (size - i - 2) : (size - i))];
            else if (endian == MY_BIG_ENDIAN)
                dst[i] = src[(i % 2 == 0 ? (i + 1) : (i - 1))];
        }
    }
}