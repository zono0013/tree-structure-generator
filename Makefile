.PHONY: create-dirs-mac

OUTPUT_DIR ?= .

create-dirs-mac:
	@if [ -z "$(FILE)" ]; then \
		echo "Error: Please specify input file with FILE=<filename>"; \
		exit 1; \
	fi
	@echo "Creating directory structure from $(FILE) in $(OUTPUT_DIR)..."
	@mkdir -p "$(OUTPUT_DIR)"
	@awk -v output_dir="$(OUTPUT_DIR)" 'NR > 1 { \
		line=$$0; \
		if (line == "") { exit; } \
		non_filename_char_count = gsub(/[│├└──  ]/, "", line); \
		level = int( non_filename_char_count / 4 - 1); \
		full_pass = output_dir; \
		is_dir = (line !~ /\.[^\/]+$$/ && line !~ /Dockerfile|Makefile|README|LICENSE|CHANGELOG|CONTRIBUTING|Vagrantfile|Gemfile|Procfile|Brewfile/); \
		if (line != "") { \
			if (is_dir) { \
				sub(/\/$$/, "", line); \
				dirs[level] = line; \
				for (i = 0; i < level; i++) { \
					full_pass = (full_pass ? full_pass "/" : "") dirs[i]; \
				} \
				full_pass = (full_pass ? full_pass "/" : "") line; \
				system("mkdir -p \"" full_pass "\""); \
			} else { \
				for (i = 0; i < level; i++) { \
					full_pass = (full_pass ? full_pass "/" : "") dirs[i]; \
				} \
				full_pass = (full_pass ? full_pass "/" : "") line; \
				system("touch \"" full_pass "\""); \
			} \
		} \
	}' $(FILE)
	@echo "Done!"