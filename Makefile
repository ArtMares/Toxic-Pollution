PKG_NAME := $(shell cat PKG_NAME)
PACKAGE_NAME := $(if $(PKG_NAME),$(PKG_NAME),$(error No package name, please create PKG_NAME))
BUILD_DIR := build

ifneq ($(wildcard SHORT_VERSION),)
	VERSION := $(shell cat SHORT_VERSION || true)
	BUILD_NUMBER := $(shell git describe --tags --match 'v[0-9]*.[0-9]*' --long|cut -d- -f2 || echo 1)
	VERSION_STRING := $(if $(VERSION),$(VERSION).$(BUILD_NUMBER),$(error No version supplied, please add it as 'VERSION=x.y'))
else
	VERSION := $(shell cat VERSION || true)
	VERSION_STRING := $(if $(VERSION),$(VERSION),$(error No version supplied, please add it as 'VERSION=x.y.z'))
endif

OUTPUT_NAME := $(PACKAGE_NAME)_$(VERSION_STRING)
OUTPUT_DIR := $(BUILD_DIR)/$(OUTPUT_NAME)

PKG_COPY := $(wildcard *.md) $(shell cat PKG_COPY || true)

SED_FILES := $(shell find . -iname "*.json" -type f \! -path "./pkg/*" -type f \! -path "./.git/*" \! -path "./$(BUILD_DIR)/*") \
             $(shell find . -iname "*.lua" -type f \! -path "./pkg/*" -type f \! -path "./.git/*" \! -path "./$(BUILD_DIR)/*")

OUT_FILES := $(SED_FILES:%=$(OUTPUT_DIR)/%)

SED_EXPRS := -e 's/{{MOD_NAME}}/$(PACKAGE_NAME)/g'
SED_EXPRS += -e 's/{{VERSION}}/$(VERSION_STRING)/g'

all: clean check package release

clean:
	@echo "Clean build directory"
	@rm -rf $(BUILD_DIR)

check:
	@echo 'Checking lua files for errors'
	@set -e; for file in $$(find . -iname '*.lua' -type f -not -path "./$(BUILD_DIR)/*"); do echo "Checking syntax: $$file" ; ./luac -p $$file; done;

package: $(FILES)
	@echo 'Copying files'
	@mkdir -p $(BUILD_DIR)/$(OUTPUT_NAME)
	@cp -r $(PKG_COPY) $(OUTPUT_DIR)
#	@echo $(SED_FILES)
#	@cp -r $(SED_FILES) $(OUTPUT_DIR)
	@cp *.lua $(OUTPUT_DIR)
	@sed $(SED_EXPRS) ./info.json > $(OUTPUT_DIR)/./info.json
	@cp LICENSE $(BUILD_DIR)/$(OUTPUT_NAME)/LICENSE.md

release:
	@echo 'Making Release'
	@cd $(BUILD_DIR) && zip -rq ../pkg/$(OUTPUT_NAME).zip $(OUTPUT_NAME)
	@rm -f ../../ModMyFactory/mods/0.18/$(PACKAGE_NAME)*
	@rm -f f:/CloudDisk/YandexDisk/Factorio/$(PACKAGE_NAME)*
	@echo $(OUTPUT_NAME).zip ready
	@echo "Copy to work directory"
	cp pkg/$(OUTPUT_NAME).zip ../../ModMyFactory/mods/0.18/
	cp pkg/$(OUTPUT_NAME).zip f:/CloudDisk/YandexDisk/Factorio