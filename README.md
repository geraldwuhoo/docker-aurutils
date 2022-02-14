# docker-aurutils

[![pipeline status](https://gitlab.com/geraldwuhoo/docker-aurutils/badges/master/pipeline.svg)](https://gitlab.com/geraldwuhoo/docker-aurutils/-/commits/master)

`aurutils` packaged into a Docker container. Useful in any environment in which it's inpractical to spin up a chroot on the host.

Potential uses:
1. Running `aurutils` within an unprivileged LXC container.
1. Running `aurutils` on a system without `sudo`.

In all of the above cases, creating a chroot with `aur sync -c` fails.

## How to use

It's recommended to create an alias for easier usage:

```sh
alias daur="docker run --rm -it -v ${REPO_PATH}:/repo registry.gitlab.com/geraldwuhoo/aurutils:latest aur"
```

where `${REPO_PATH}` is the path on the host where the repository lives.

Then, you may use `daur` in the same way as `aur`. For example:

```sh
$ daur sync -u
:: Synchronizing package databases...
 core is up to date
 extra is up to date
 community is up to date
 multilib    148.6 KiB   149 KiB/s 00:01 [################################] 100%
 custom      493.0   B   241 KiB/s 00:00 [################################] 100%
:: Starting full system upgrade...
 there is nothing to do
==> Using [custom] repository
    there is nothing to do
```

If there does not exist an existing repository at `${REPO_PATH}`, then the container will create and initialize one. If there does exist a repository, then it will use the existing one.
