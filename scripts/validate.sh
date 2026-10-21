#!/usr/bin/env bash
set -euo pipefail
bash ci/test.sh
python3 - <<'PY'
import pathlib
try:
    import yaml
except ImportError:
    raise SystemExit('PyYAML is required: pip install pyyaml')
for dirname in ('k8s','argocd','infra'):
    for p in pathlib.Path(dirname).rglob('*.yaml'):
        with p.open() as f:
            list(yaml.safe_load_all(f))
        print('YAML validated:',p)
PY
if command -v kubectl >/dev/null; then kubectl kustomize k8s >/dev/null; fi
