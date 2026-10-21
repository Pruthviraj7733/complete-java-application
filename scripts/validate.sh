#!/usr/bin/env bash
set -euo pipefail
bash ci/test.sh
command -v kubectl >/dev/null && kubectl apply --dry-run=client --validate=false -f k8s/namespace.yaml >/dev/null || true
if command -v python3 >/dev/null; then
 python3 - <<'PY'
try: import yaml
except ImportError: raise SystemExit('Install PyYAML: python3 -m pip install pyyaml')
import pathlib
for folder in ['k8s','argocd','infra']:
 for p in pathlib.Path(folder).rglob('*.yaml'):
  list(yaml.safe_load_all(p.read_text()))
  print('YAML OK:',p)
PY
fi
