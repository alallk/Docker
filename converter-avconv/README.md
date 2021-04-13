# media-converter
A docker container to convert your `mkv` files to an `mp4` format

### How does it work?

It searches through a specified list of directories for all files ending with
`*.mkv` and then uses the `avconv` tool to convert these files to the `mp4`
format.

### Customization using environment variables
PRESERVE_DIR_STRUCTURE = if set to true, destination files end up in the same directory as the originals.
DELETE_ORIGINAL_ON_SUCCESS = if set to true, the original file is deleted IF the conversion succeeds.

### How do I use this?

You should be able to run the docker container using something along the lines
of:

```bash
docker run --rm -ti -v `pwd`:/files {Image Name}
```
