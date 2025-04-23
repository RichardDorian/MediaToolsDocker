# MediaToolsDocker

This docker image contains a set of tools for media processing, including:

- [`ffmpeg`](https://www.ffmpeg.org/)
- [`MediaInfo`](https://mediaarea.net/en/MediaInfo)
- [`MKVToolNix`](https://mkvtoolnix.download/)
- [`MakeMKV`](https://www.makemkv.com/)

## To do

- [ ] Make this image lighter
- [ ] Add more tools if needed
- [ ] Make a "host" script to access the tools within the container easily on the host

## Copyright

I do not own any of the above software. Copyright and licenses are owned by their respective authors. This image is provided for convenience and is not intended for commercial use.

MakeMKV comes with a eula that you must accept. The script will automatically accept the eula in order to automate the install process (eula acceptance is required for installation). If you do not want to accept the eula do **not** use this image.
