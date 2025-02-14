#!/bin/bash

set -ouex pipefail

_remove_metadata_from_images_and_videos() {
    cmd="./_pages/2025/02/13/a-script-to-remove-metadata-from-images-and-videos/rm_metadata.sh"
    chmod +x $cmd
    $cmd --recursive --debug '.'
}

_main() {
    _remove_metadata_from_images_and_videos
}

_main