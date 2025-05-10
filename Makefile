# Help target - lists available commands
help:
	@echo "Available commands:"
	@echo "  make icons    - Generate app launcher icons using flutter_launcher_icons"

# Generate app launcher icons
icons:
	dart run flutter_launcher_icons

# Default target (runs when you just type 'make')
.DEFAULT_GOAL := help