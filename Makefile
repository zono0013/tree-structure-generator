.PHONY: create-dirs
create-dirs:
	@if [ -z "$(FILE)" ]; then \
		echo "Error: Please specify input file with FILE=<filename>"; \
		exit 1; \
	fi
	@if [ "$(MAKEFLAGS)" = "-r" ]; then \
		awk_condition="NR > 0"; \
	else \
		awk_condition="NR > 1"; \
	fi
	@echo "Creating directory structure from $(FILE)..."
	@awk 'NR > 1 { \
		line=$$0; \
		gsub(/[│├└──]/, "", line); \
		num_spaces = gsub(/ /, "", $$0); \
		level = int( (num_spaces -1) / 3); \
		i = 0; \
		fullpass = ""; \
		if (line ~ /\/$$/) { \
			sub(/\/$$/, "", line); \
			gsub(/^[ \t]+|[ \t]+$$/, "", line); \
			if (line != "") { \
				dirs[level] = line; \
				print "level: " level; \
				for (i = 0; i < level; i++) { \
					fullpass = (fullpass ? fullpass "/" : "") dirs[i]; \
				} \
				fullpass = (fullpass ? fullpass "/" : "") line; \
				print "Full path: " fullpass; \
				system("mkdir -p \"" fullpass "\""); \
			} \
		} else { \
			gsub(/^[ \t]+|[ \t]+$$/, "", line); \
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
