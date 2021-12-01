TARGET_EXEC ?= Main.out

BUILD_DIR ?= ./build
SRC_DIRS ?= ./

SRCS += ByteReader.cpp
SRCS += CAFFdto.cpp
SRCS += CIFFdto.cpp
SRCS += JsonUtil.cpp
SRCS += CAFFParser.cpp
SRCS += Main.cpp

OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)

CXX ?= g++
CXXFLAGS ?= -std=c++14

CPPFLAGS ?= -MMD -MP

MKDIR_P ?= mkdir -p

edit : $(BUILD_DIR)/CAFFParser.exe

$(BUILD_DIR)/CAFFParser.exe : $(OBJS)
	$(CXX) $(OBJS) -o $(BUILD_DIR)/CAFFParser

# c++ source
$(BUILD_DIR)/%.cpp.o: %.cpp
	$(MKDIR_P) $(dir $@)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@


.PHONY: clean

clean:
	$(RM) -r $(BUILD_DIR)

-include $(DEPS)
