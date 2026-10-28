#!/usr/bin/env bash
# Test script for: Open WebUI (tier T2, time limit 1200 s)
# Run by src/sandbox/sandbox_suite.py inside an isolated HOME on a small CPU instance.
pip install -q open-webui >/dev/null 2>&1; (DATA_DIR=$PWD/data timeout 240 open-webui serve --port 4020 >serve.log 2>&1 &); for i in $(seq 1 40); do sleep 5; c=$(curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:4020/health); [ "$c" = 200 ] && { echo "METRIC ready_s=$((i*5))"; break; }; done; ps -eo rss,cmd | grep -i open-webui | sort -rn | head -2; du -sh $(python -c "import open_webui,os;print(os.path.dirname(open_webui.__file__))")
