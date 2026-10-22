<!-- markdownlint-disable MD040 -->
# Contributing

Lemvos Robotics maintains these definitions.
Report a problem or a needed change in an issue; pull requests that change a message, service or action are not accepted.

Build and test the package as in the [Quick Start](README.md#quick-start); this guide lists the checks every change has to pass.

## Tests

`colcon test` runs `ament_lint_auto` with the linters of `ament_lint_common`:

| Test | Checks |
| --- | --- |
| `copyright` | That `LICENSE` and `CONTRIBUTING.md` carry the Apache License 2.0 |
| `lint_cmake` | `CMakeLists.txt` |
| `xmllint` | `package.xml`, against the format 3 schema downloaded from `download.ros.org` |
| `flake8`, `pep257` | Python files (none at present) |

`ament_copyright` recognises the Apache License only by its unmodified text, so keep `LICENSE`, including its appendix line `Copyright [yyyy] [name of copyright owner]`, and the clause under [Licensing of Contributions](#licensing-of-contributions) exactly as they are.
The copyright holder is named in the headers of `CMakeLists.txt` and `package.xml`.
The two files are checked only at the root of a git repository.

The definitions themselves are checked by `colcon build`, which fails on a definition that does not parse or names a type it cannot resolve.

CI builds the package and runs this suite on every pull request and every push to `master`, on amd64 (`ubuntu-22.04`) and arm64 (`ubuntu-22.04-arm`), in the `ros:humble-ros-base-jammy` container.
Each architecture reports its own result, and a new push to a pull request cancels the run in progress.

## Linters

CI also lints the files outside the package build; run the same checks from the repository root before a pull request:

| Check | Command | Version in CI | Configuration |
| --- | --- | --- | --- |
| YAML | `yamllint .` | 1.38.0 | `.yamllint` |
| Markdown | `docker run --rm -u "$(id -u):$(id -g)" -v "$PWD:/workdir" davidanson/markdownlint-cli2:v0.18.1 "**/*.md"` | 0.18.1 | `.markdownlint-cli2.yaml` |
| Workflows | `actionlint` | 1.7.7, with `shellcheck` | - |
| Composite action shell | `python3 .github/scripts/lint-action-scripts.py` | `shellcheck` | - |

## Licensing of Contributions

Any contribution that you make to this repository will
be under the Apache 2 License, as dictated by that
[license](http://www.apache.org/licenses/LICENSE-2.0.html):

~~~
5. Submission of Contributions. Unless You explicitly state otherwise,
   any Contribution intentionally submitted for inclusion in the Work
   by You to the Licensor shall be under the terms and conditions of
   this License, without any additional terms or conditions.
   Notwithstanding the above, nothing herein shall supersede or modify
   the terms of any separate license agreement you may have executed
   with Licensor regarding such Contributions.
~~~
