#!/usr/bin/env bash
# Test script for: Litpage (tier T2, time limit 900 s)
# Run by src/sandbox/sandbox_suite.py inside an isolated HOME on a small CPU instance.
git clone -q --depth 1 https://github.com/litmers-dev/litpage.git lp && cd lp && (time pnpm install >inst.log 2>&1) 2>&1 | tail -3; tail -2 inst.log; (time pnpm build >build.log 2>&1) 2>&1 | tail -3; tail -2 build.log; (PORT=4010 timeout 90 pnpm start >start.log 2>&1 &); sleep 35; tail -3 start.log; curl -s -o /dev/null -w 'METRIC http_code=%{http_code}\n' http://127.0.0.1:4010/ ; ps -eo rss,cmd | grep -i -E 'node' | sort -rn | head -2
