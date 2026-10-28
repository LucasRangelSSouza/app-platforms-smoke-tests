#!/usr/bin/env bash
# Test script for: Taipy (tier T2, time limit 900 s)
# Run by src/sandbox/sandbox_suite.py inside an isolated HOME on a small CPU instance.
python3 -m venv vt && . vt/bin/activate && pip install -q taipy 2>&1 | tail -2; python -c "import taipy.gui" 2>&1 | tail -1; cat > app.py <<'PY'
from taipy.gui import Gui
Gui("# Ola Taipy").run(port=4030, run_browser=False, use_reloader=False)
PY
(timeout 120 python app.py >app.log 2>&1 &); sleep 45; tail -4 app.log; ss -ltn | grep 4030 || true; curl -s -o /dev/null -w 'METRIC http_code=%{http_code}\n' http://127.0.0.1:4030/
