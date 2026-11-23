Usage
===
make noble
make run-noble

Chives on Resolute
------------------

Run `make run-chives` to open a shell in the mounted
`/source/gits/canonical/oem-python-chives` checkout using `deb:resolute-chives`,
built from `Dockerfile.chives`. Ubuntu 26.04 packages supply the dependencies;
the runner installs only the local checkout with pip in offline mode, without
`uv`. Run `chives-copy-package` directly in the shell.
`make run-resolute` still uses the separate `deb:resolute` packaging image.

For live lookups, put `CHIVES_LP_CONSUMER_KEY`, `CHIVES_LP_ACCESS_TOKEN`,
`CHIVES_LP_ACCESS_SECRET`, and `CHIVES_CESG_URL` in
`/work/init/dotfiles_c/pes/chives.env`. Use Bash `NAME='value'` assignments
with no spaces around `=`, and keep the file private. `make run-chives` mounts
it read-only and the runner sources it before opening the shell. Only use a
file you trust, since Bash executes commands in a sourced file. Use
`make run-chives CHIVES_ENV_FILE=/path/to/chives.env` to choose another file.
For devel-to-staging copies, set `CHIVES_PROD_REPO` to the container path of
the `oem-archive` production checkout. Use `--dry-run` to preview without
submitting a request.
