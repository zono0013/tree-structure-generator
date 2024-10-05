.PHONY: create-dirs-mac
create-dirs-mac:
	@if [ -z "$(FILE)" ]; then \
		echo "Error: Please specify input file with FILE=<filename>"; \
		exit 1; \
	fi
	@echo "Creating directory structure from $(FILE)..."
	@awk 'NR > 1 { \
		line=$$0; \
		num = gsub(/[│├└──]/, "", line); \
		print "num: " num; \
		num_spaces = gsub(/ /, "", line); \
		print "num_spaces: " num_spaces; \
		num_nbsp_spaces = gsub(/ /, "", line); \
		print "num_nbsp_spaces: " num_nbsp_spaces; \
		level = int( (num_spaces + num_nbsp_spaces + num) / 4 - 1); \
		print "level: " level; \
		i = 0; \
		fullpass = ""; \
		is_dir = (line !~ /\.[^\/]+$$/ && line !~ /Dockerfile$$/ && line !~ /Dockerfile$$/ && line !~ /Makefile$$/ && line !~ /README$$/ && line !~ /LICENSE$$/ && line !~ /CHANGELOG$$/ && line !~ /CONTRIBUTING$$/ && line !~ /Vagrantfile$$/ && line !~ /Gemfile$$/ && line !~ /Procfile$$/ && line !~ /Brewfile$$/); \
		print "is_dir: " is_dir; \
		if (line != "") { \
			if (is_dir) { \
				sub(/\/$$/, "", line); \
				dirs[level] = line; \
				for (i = 0; i < level; i++) { \
					fullpass = (fullpass ? fullpass "/" : "") dirs[i]; \
				} \
				fullpass = (fullpass ? fullpass "/" : "") line; \
				print "Full path: " fullpass; \
				system("mkdir -p \"" fullpass "\""); \
			} else { \
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