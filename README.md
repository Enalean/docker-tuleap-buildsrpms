docker-tuleap-buildsrpm
=========================

This repo is not maintained anymore, check [tuleap-generated-files-builder](https://tuleap.net/plugins/git/tuleap/docker/tuleap-generated-files-builder)
and [docker-tuleap-buildrpms](https://github.com/Enalean/docker-tuleap-buildrpms).

This image is intended to build srpm from Tuleap Sources.

## Choose your NPM registry and user

This image let you choose the NPM registry you want to use.
The following environment variables can be used for the configuration:
  * ``NPM_REGISTRY``: registry address
  * ``NPM_USER``: user name used to log in into the registry
  * ``NPM_PASSWORD``: password of the user
  * ``NPM_EMAIL``: public mail associated with the user
