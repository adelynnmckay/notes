#!/bin/bash

set -ouex pipefail

# Supported image and video formats
IMAGE_EXTENSIONS="jpg|jpeg|png|gif|tiff|webp|bmp"
VIDEO_EXTENSIONS="mp4|mov|avi|mkv|webm|flv"

# Default options
RECURSIVE=false
DEBUG_MODE=false

# Function to display help text
show_help() {
    echo "Usage: $0 [OPTIONS] <file_or_directory>"
    echo ""
    echo "Removes all metadata from image and video files."
    echo ""
    echo "Options:"
    echo "  --recursive       Process directories recursively"
    echo "  --debug           Enable debug mode"
    echo "  -h, --help        Show this help message"
    echo ""
    exit 0
}

# Function to check and install dependencies
install_dependencies() {
    local packages=("exiftool" "ffmpeg")

    for package in "${packages[@]}"; do
        if ! command -v "$package" &> /dev/null; then
            echo "Dependency '$package' is missing. Installing..."
            
            if [[ "$OSTYPE" == "darwin"* ]]; then
                # macOS
                if command -v brew &> /dev/null; then
                    brew install "$package"
                else
                    echo "Error: Homebrew is not installed. Please install Homebrew first."
                    exit 1
                fi
            elif [[ -f "/etc/debian_version" ]]; then
                # Debian-based Linux (Ubuntu, Debian, etc.)
                sudo apt-get update && sudo apt-get install -y "$package"
            else
                echo "Error: Unsupported OS. Please install '$package' manually."
                exit 1
            fi
        fi
    done
}

remove_image_metadata() {
    local file="$1"
    echo "Processing image: $file"
    exiftool -all= -overwrite_original "$file"
}

remove_video_metadata() {
    local file="$1"
    echo "Processing video: $file"
    ffmpeg -i "$file" -map_metadata -1 -c:v copy -c:a copy "$file.tmp"

    if [ $? -eq 0 ]; then
        mv "$file.tmp" "$file"
        echo "Metadata removed from: $file"
    else
        echo "Error processing video file: $file"
    fi
}

# Function to remove metadata from a file
remove_metadata() {
    local file="$1"
    local ext="${file##*.}"
    local ext_lower=$(echo "$ext" | tr '[:upper:]' '[:lower:]')
    if [[ "$ext_lower" =~ ^($IMAGE_EXTENSIONS)$ ]]; then
        remove_image_metadata "$file"
    elif [[ "$ext_lower" =~ ^($VIDEO_EXTENSIONS)$ ]]; then
        remove_video_metadata "$file"
    fi
}

# Function to process files in a directory
process_directory() {
    local dir="$1"
    local find_opts=()
    local all_extensions="$IMAGE_EXTENSIONS|$VIDEO_EXTENSIONS"
    all_extensions=$(echo $all_extensions | tr '|' ' ')

    for ext in $all_extensions; do
        find_opts=()
        find_opts+=("-name" "*.$ext")
        if [ "$RECURSIVE" = true ]; then
            find_opts+=("-type" "f")
        else
            find_opts+=("-maxdepth" "1" "-type" "f")
        fi
        find "$dir" "${find_opts[@]}" | while read -r file; do
            remove_metadata "$file"
        done
    done
}

# Parse command-line arguments
POSITIONAL_ARGS=()
while [[ $# -gt 0 ]]; do
    case "$1" in
        --recursive)
            RECURSIVE=true
            shift
            ;;
        --debug)
            DEBUG_MODE=true
            shift
            ;;
        -h|--help)
            show_help
            ;;
        *)
            POSITIONAL_ARGS+=("$1")
            shift
            ;;
    esac
done

# Enable debug mode if requested
if [ "$DEBUG_MODE" = true ]; then
    set -x
fi

# Check if a file or directory was provided
if [ ${#POSITIONAL_ARGS[@]} -eq 0 ]; then
    echo "Error: No file or directory specified."
    show_help
fi

# Check and install dependencies if needed
install_dependencies

# Process each provided file or directory
for item in "${POSITIONAL_ARGS[@]}"; do
    if [ -f "$item" ]; then
        remove_metadata "$item"
    elif [ -d "$item" ]; then
        process_directory "$item"
    else
        echo "Error: '$item' is not a valid file or directory."
    fi
done
