.PHONY: create-dirs-mac
create-dirs-mac:
	@if [ -z "$(FILE)" ]; then \
		echo "Error: Please specify input file with FILE=<filename>"; \
		exit 1; \
	fi
	@echo "Creating directory structure from $(FILE)..."
	@awk 'NR > 1 { \
		line=$$0; \
		if (line == "") { exit; } \
		non_filename_char_count = gsub(/[│├└──]/, "", line); \
		non_filename_char_count += gsub(/ /, "", line); \
		non_filename_char_count += gsub(/ /, "", line); \
		level = int( non_filename_char_count / 4 - 1); \
		i = 0; \
		fullpass = ""; \
		is_dir = (line !~ /\.[^\/]+$$/ && line !~ /Dockerfile$$/ && line !~ /Dockerfile$$/ && line !~ /Makefile$$/ && line !~ /README$$/ && line !~ /LICENSE$$/ && line !~ /CHANGELOG$$/ && line !~ /CONTRIBUTING$$/ && line !~ /Vagrantfile$$/ && line !~ /Gemfile$$/ && line !~ /Procfile$$/ && line !~ /Brewfile$$/); \
		if (line != "") { \
			if (is_dir) { \
				sub(/\/$$/, "", line); \
				dirs[level] = line; \
				for (i = 0; i < level; i++) { \
					fullpass = (fullpass ? fullpass "/" : "") dirs[i]; \
				} \
				fullpass = (fullpass ? fullpass "/" : "") line; \
				system("mkdir -p \"" fullpass "\""); \
			} else { \
				for (i = 0; i < level; i++) { \
					fullpass = (fullpass ? fullpass "/" : "") dirs[i]; \
				} \
				fullpass = (fullpass ? fullpass "/" : "") line; \
				system("touch \"" fullpass "\""); \
			} \
		} \
	}' $(FILE)
	@echo "Done!"