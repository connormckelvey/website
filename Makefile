BUILD_DIR ?= build
SOURCE_DIR ?= src

.PHONY: clean requirements
.DEFAULT_GOAL := $(BUILD_DIR)

serve: requirements $(SOURCE_DIR)
	@bundle exec jekyll serve -s $(SOURCE_DIR) -d $(BUILD_DIR)

$(BUILD_DIR): requirements $(SOURCE_DIR)
	@bundle exec jekyll build -s $(SOURCE_DIR) -d $(BUILD_DIR)
	@echo built site

clean:
	@git clean -fdX

requirements: requirements.log
requirements.log: Gemfile
	@bundle install > requirements.log
	@echo installed requirements
