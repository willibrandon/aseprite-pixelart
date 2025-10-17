#!/bin/bash
# Helper script to detect Aseprite installation path

set -e

# Common installation paths by platform
detect_aseprite() {
    local OS="$(uname -s)"

    case "$OS" in
        Darwin)
            # macOS paths
            local PATHS=(
                "/Applications/Aseprite.app/Contents/MacOS/aseprite"
                "$HOME/Applications/Aseprite.app/Contents/MacOS/aseprite"
                "/usr/local/bin/aseprite"
                "$HOME/.local/bin/aseprite"
            )
            ;;
        Linux)
            # Linux paths
            local PATHS=(
                "/usr/bin/aseprite"
                "/usr/local/bin/aseprite"
                "$HOME/.local/bin/aseprite"
                "$HOME/bin/aseprite"
                "/opt/aseprite/bin/aseprite"
                "/snap/bin/aseprite"
            )
            ;;
        MINGW*|MSYS*|CYGWIN*)
            # Windows paths (Git Bash / MSYS / Cygwin)
            local PATHS=(
                "/c/Program Files/Aseprite/Aseprite.exe"
                "/c/Program Files (x86)/Aseprite/Aseprite.exe"
                "$HOME/AppData/Local/Aseprite/Aseprite.exe"
            )
            ;;
        *)
            echo "Error: Unsupported operating system: $OS" >&2
            return 1
            ;;
    esac

    # Check each path
    for path in "${PATHS[@]}"; do
        if [ -x "$path" ]; then
            echo "$path"
            return 0
        fi
    done

    # Not found
    return 1
}

# Main execution
if detect_aseprite; then
    exit 0
else
    echo "Error: Aseprite not found in common installation paths" >&2
    echo "" >&2
    echo "Please install Aseprite from: https://www.aseprite.org/" >&2
    echo "Or specify the path manually using: /pixel-setup" >&2
    exit 1
fi
