#!/usr/bin/env python3

"""Run shellcheck over the run blocks of every local composite action.

actionlint covers .github/workflows, but it parses a composite action as a
workflow and rejects it, so .github/actions/*/action.yaml is linted here
instead. Run from the repository root, the same way CI does:

    python3 .github/scripts/lint-action-scripts.py
"""

import glob
import subprocess
import sys

import yaml

ACTION_GLOB = '.github/actions/*/action.yaml'


def lint_action(path: str) -> bool:
    """Shellcheck every run block in one action file. True if all pass."""
    with open(path, encoding='utf-8') as handle:
        action = yaml.safe_load(handle)

    ok = True
    for step in action['runs']['steps']:
        if 'run' not in step:
            continue
        name = step.get('name', '<unnamed step>')
        # shellcheck needs a shebang to pick the dialect when reading stdin.
        script = '#!/usr/bin/env bash\n' + step['run']
        result = subprocess.run(
            ['shellcheck', '--shell=bash', '-'],
            input=script, capture_output=True, text=True, check=False)
        if result.returncode != 0:
            ok = False
            print(f'::error::shellcheck failed: {path}: {name}')
            print(result.stdout)
    return ok


def main() -> int:
    paths = sorted(glob.glob(ACTION_GLOB))
    if not paths:
        print(f'::error::no composite actions matched {ACTION_GLOB}')
        return 1

    failed = [path for path in paths if not lint_action(path)]
    for path in paths:
        print(f'{"FAIL" if path in failed else "ok  "}  {path}')
    return 1 if failed else 0


if __name__ == '__main__':
    sys.exit(main())
