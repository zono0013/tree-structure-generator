.PHONY: create-dirs-mac
create-dirs-mac:
	@if [ -z "$(FILE)" ]; then \
		echo "Error: Please specify input file with FILE=<filename>"; \
		exit 1; \
	fi
	@echo "Creating directory structure from $(FILE)..."
	@awk 'NR > 1 { \
		line=$$0; \
		gsub(/[│├└──]/, "", line); \
		num_spaces = gsub(/ /, "", $$0); \
		print "num_spaces: " num_spaces; \
		num_nbsp_spaces = gsub(/ /, "", $$0); \
		print "num_nbsp_spaces: " num_nbsp_spaces; \
		level = int( (num_spaces -1 + num_nbsp_spaces) / 3); \
		print "level: " level; \
		i = 0; \
		fullpass = ""; \
		gsub(/[ ]/, "", line); \
		gsub(/^[ \t]+|[ \t]+$$/, "", line); \
		is_dir = (line !~ /\.[^\/]+$$/ && line !~ /Dockerfile$$/ && line !~ /Dockerfile$$/ && line !~ /Makefile$$/ && line !~ /README$$/ && line !~ /LICENSE$$/ && line !~ /CHANGELOG$$/ && line !~ /CONTRIBUTING$$/ && line !~ /Vagrantfile$$/ && line !~ /Gemfile$$/ && line !~ /Procfile$$/ && line !~ /Brewfile$$/); \
		print "is_dir: " is_dir; \
		if (is_dir) { \
			sub(/\/$$/, "", line); \
			if (line != "") { \
				dirs[level] = line; \
				for (i = 0; i < level; i++) { \
					fullpass = (fullpass ? fullpass "/" : "") dirs[i]; \
				} \
				fullpass = (fullpass ? fullpass "/" : "") line; \
				print "Full path: " fullpass; \
				system("mkdir -p \"" fullpass "\""); \
			} \
		} else { \
			if (line != "") { \
				for (i = 0; i < level; i++) { \
					fullpass = (fullpass ? fullpass "/" : "") dirs[i]; \
				} \
				fullpass = (fullpass ? fullpass "/" : "") line; \
				print "Full path: " fullpass; \
				system("touch \"" fullpass "\""); \
			} \
		} \
	}' $(FILE)
	@echo "Done!"