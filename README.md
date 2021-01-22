# Kartoza GeoNode Image

This GeoNode docker image repo is used to store Kartoza's custom built GeoNode
Image.


# Building the image

## Manual local build

To build the image locally, copy the file `.example.env` into `.env` and modify the build parameter.

Build the image using docker-compose:

```bash
docker-compose build geonode
```

The image will be available by default as `kartoza/geonode:base-latest`.
To change the default image name and tag, simply override `IMAGE_NAME` and `IMAGE_TAG`
parameter in the `.env` file

## Build the image using Github Action

Latest image are built automatically into default tag `kartoza/geonode:base-latest`.


