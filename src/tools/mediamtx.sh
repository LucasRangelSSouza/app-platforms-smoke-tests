#!/usr/bin/env bash
# Test script for: MediaMTX (tier T2, time limit 300 s)
# Run by src/sandbox/sandbox_suite.py inside an isolated HOME on a small CPU instance.
curl -sL https://github.com/bluenviron/mediamtx/releases/latest/download/mediamtx_linux_amd64.tar.gz -o m.tgz 2>/dev/null; URL=$(curl -s https://api.github.com/repos/bluenviron/mediamtx/releases/latest | python -c "import sys,json;a=json.load(sys.stdin)['assets'];print([x['browser_download_url'] for x in a if x['name'].endswith('linux_amd64.tar.gz')][0])"); curl -sL $URL -o m.tgz && tar xzf m.tgz; (./mediamtx >mtx.log 2>&1 &); sleep 2
ffmpeg -loglevel error -re -f lavfi -i testsrc2=size=1280x720:rate=15 -t 20 -c:v libx264 -preset ultrafast -tune zerolatency -f rtsp rtsp://127.0.0.1:8554/cam1 &
sleep 4; python - <<'PY'
import subprocess,time
t0=time.time(); o=subprocess.run(["ffprobe","-v","error","-rtsp_transport","tcp","-show_entries","stream=codec_name,width,height,avg_frame_rate","-of","csv=p=0","rtsp://127.0.0.1:8554/cam1"],capture_output=True,text=True,timeout=30)
print("METRIC probe_ms=%d"%((time.time()-t0)*1000), o.stdout.strip())
PY
ps -eo rss,cmd | grep mediamtx | head -1; pkill mediamtx
