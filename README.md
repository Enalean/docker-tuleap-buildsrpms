docker-tuleap-buildsrpm
=========================

This image is intended to build srpm from Tuleap Sources.

## Choose your NPM registry and user

This image let you choose the NPM registry you want to use.
The following environment variables can be used for the configuration:
  * ``NPM_REGISTRY``: registry address
  * ``NPM_USER``: user name used to log in into the registry
  * ``NPM_PASSWORD``: password of the user
