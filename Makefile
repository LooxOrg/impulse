PROJECT_NAME := impulse

CC ?= gcc
CXX ?= g++

ifeq ($(OS), Windows_NT)
	CUR_OS := win32
else
	UNAME := $(shell uname)
	ifeq ($(UNAME), Linux)
		CUR_OS := linux
	else ifeq ($(UNAME), Darwin)
		CUR_OS := darwin
	else ifeq ($(UNAME), Orchid)
		CUR_OS := orchid
	endif
endif

ifeq ($(CUR_OS), win32)
	ARCH = x86_64
else
	ARCH ?= $(shell uname -m)
endif

ifeq ($(CUR_OS), win32)
	SEP = \\
else
	SEP = /
endif

ifeq ($(CUR_OS), win32)
	CFLAGS = -Wall -g -std=c11 -Isupport/win32/include -I.
	CXXFLAGS = -Wall -g -std=c++17 -Iinclude
	LDFLAGS = -Llib -lopengl32 -lglu32 -lgdi32 -ldwmapi -lshell32 -lshcore
else
	CFLAGS = -Wall -g -std=c11 -I.
	CXXFLAGS = -Wall -g -std=c++17 -I.
	LDFLAGS =	-lX11 -lGL -lGLU
endif

CSRC :=
CXXSRC := src/main.cpp
COBJ = $(CSRC:.c=.o)
CXXOBJ = $(CXXSRC:.cpp=.o)

BUILD_DIR := build
BUILD_STAGE_DIR := build_stage
APP_OUTPUT := $(BUILD_STAGE_DIR)$(SEP)$(PROJECT_NAME)-$(CUR_OS)-$(ARCH)

ifeq ($(CUR_OS), win32)
	RM = cmd /C del /F /Q
	RMDIR = rmdir /S /Q
	COBJ_TARGET = $(subst /,\,$(COBJ))
	CXXOBJ_TARGET = $(subst /,\,$(CXXOBJ))
	BUILD_STAGE_DIR_TARGET = $(subst /,\,$(BUILD_STAGE_DIR))
else
	RM = rm -rf
	COBJ_TARGET = $(COBJ)
	CXXOBJ_TARGET = $(CXXOBJ)
	BUILD_STAGE_DIR_TARGET = $(BUILD_STAGE_DIR)
endif

.PHONY: all prebuild $(PROJECT_NAME) postbuild clean
all: prebuild $(PROJECT_NAME) postbuild

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

%.o: %.rc
	windres $< -O coff -o $@

prebuild:
ifeq ($(CUR_OS), win32)
	@if not exist "$(APP_OUTPUT)" mkdir "$(APP_OUTPUT)"
else
	mkdir -p "$(APP_OUTPUT)"
endif

$(PROJECT_NAME): $(COBJ) $(CXXOBJ)
	$(CXX) -o $(APP_OUTPUT)$(SEP)$(PROJECT_NAME) $(COBJ) $(CXXOBJ) $(LDFLAGS)

# postbuild:
# ifeq ($(ORCHID_SDK_OS), win32)
# 	python $(BUILD_DIR)$(SEP)create_md5_hashes.py $(APP_OUTPUT) $(APP_OUTPUT)$(SEP)hashes.md5
# else
# 	python3 $(BUILD_DIR)$(SEP)create_md5_hashes.py $(APP_OUTPUT) $(APP_OUTPUT)$(SEP)hashes.md5
# endif

clean:
ifeq ($(CUR_OS), win32)
	$(RM) $(COBJ_TARGET) $(CXXOBJ_TARGET)
	$(RMDIR) $(BUILD_STAGE_DIR_TARGET)
else
	$(RM) $(COBJ_TARGET) $(CXXOBJ_TARGET) $(BUILD_STAGE_DIR_TARGET)
endif
