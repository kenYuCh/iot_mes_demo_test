# Firmware staging directory

Place administrator-approved `.bin` files in this directory before importing
them from the Flutter OTA asset library. The server validates the filename,
reads the file itself, and calculates its byte size and SHA-256 checksum.

Production deployments should set `FIRMWARE_STORAGE_PATH` to a persistent,
access-controlled volume or replace this local store with object storage.

Do not commit production firmware binaries or signing keys to source control.
