# CI and Release

The workflows in `.github/workflows/` and how a release is published.
What CI checks on a pull request is in [CONTRIBUTING.md](../CONTRIBUTING.md#tests).

## Table of Contents

- [Workflows](#workflows)
- [Releasing](#releasing)
- [Repository Settings](#repository-settings)
- [Dependabot](#dependabot)

## Workflows

| Workflow | Trigger | What it does |
| --- | --- | --- |
| `ros2-ci.yaml` | push to `master`, pull request, manual | Builds and tests on amd64 and arm64, and runs `actionlint`, `yamllint` and `markdownlint`. |
| `publish-deb.yaml` | push of a `v*` tag, manual from a tag | Builds the arm64 and amd64 Debian packages, after checking that the tag is on `master` and matches `package.xml`, and publishes them to Cloudsmith. |

Both workflows grant the token `contents: read` only, leave it out of every checkout's git config, run every `run:` step in `bash`, pin every third-party action to a commit SHA, and pin the container image by digest.

The build job of `ros2-ci.yaml` builds into `/ros_ws`, outside the checkout, so no generated file lands in the source tree.
The container jobs run as root and end with the `restore-workspace-ownership` composite action, which returns the checkout to the runner user even when an earlier step failed.

## Releasing

Publishing is tag-driven: a Cloudsmith version is immutable, so a release is one deliberate `v*` tag rather than a consequence of a merge.
A manual run of `publish-deb.yaml` has to select a tag as well.

1. Merge the release pull request, with the version in `package.xml` and the dated section in `CHANGELOG.rst`, to `master`.
2. Tag the merge commit `v<version>` and push the tag.
3. `verify-tag`, on a GitHub-hosted runner, rejects a ref that is not a tag, a tag whose commit is not on `master`, and a tag whose version, without the leading `v`, differs from the `<version>` in `package.xml`.
   The workflow does not re-run `ros2-ci.yaml`; it relies on the tagged commit being on `master`.
4. `build-deb` builds the `.deb` once per architecture, as root in the digest-pinned `ros:humble-ros-base-jammy` container, with a 45-minute timeout, on GitHub's `ubuntu-22.04-arm` and `ubuntu-22.04` runners.
   It runs `bloom-generate rosdebian` and `fakeroot debian/rules binary`; bloom takes the version from `package.xml`.
5. `publish-deb` runs only when both builds succeed, installs the Cloudsmith CLI, pinned at 1.20.2, and pushes both packages to `<CLOUDSMITH_OWNER>/<CLOUDSMITH_REPO>/ubuntu/jammy`.

The release workflow has no concurrency group, so every tag builds.

The packages that depend on this one check it out at a pinned tag in their own CI, so a release is complete once they move to the new tag.

> [!CAUTION]
> A push to Cloudsmith cannot be undone.
> The push runs without `--republish`, so a version already on Cloudsmith fails the release instead of replacing a `.deb` a host has installed.
> The two packages are pushed one after the other, so a failure after the first leaves that one published alone; release the next version rather than retry this one.

## Repository Settings

| Name | Kind | Used by | Purpose |
| --- | --- | --- | --- |
| `CLOUDSMITH_API_KEY` | Actions secret | `publish-deb.yaml` | Authenticates the Cloudsmith push. |
| `CLOUDSMITH_OWNER` | Actions variable | `publish-deb.yaml` | Owner part of the Cloudsmith upload path. |
| `CLOUDSMITH_REPO` | Actions variable | `publish-deb.yaml` | Repository part of the Cloudsmith upload path. |

The publish step stops with an error when the Cloudsmith secret or either variable is empty.
Every job runs on a GitHub-hosted runner; a public repository must not use a self-hosted one, because a pull request from a fork could run code on it.

## Dependabot

`.github/dependabot.yml` keeps the SHA-pinned `uses:` refs current, weekly, with one grouped pull request for the workflows and one for the composite actions under `.github/actions/*`, and a `chore` commit prefix.
Every update is a pull request that a person reviews and merges; nothing grants automerge.
The digest-pinned container image and the `actionlint` version and checksum are outside its reach and are bumped by hand.
