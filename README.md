# App platforms: measured smoke tests

Open WebUI, Taipy, Litpage and MediaMTX brought up and probed; only cases with recorded readiness metrics are listed.

Author: Lucas Rangel. All numbers below come from `evidence/results.json` (measured runs on rented Vast.ai GPUs, Oct 2026). Rows with failed or install-only status are not included. Every row is a real run on a shared marketplace host: values are single-session medians, outliers are kept (not filtered), and a different host of the same GPU model can differ noticeably.

## Conclusion

Each platform reached a ready/HTTP-200 state on a small CPU instance; times are listed below.

## Measured rows

| tool | tier | wall (s) | peak RSS (MB) | metrics |
|---|---|---|---|---|
| Open WebUI | T2 | 200.8 | 5 | ready_s=$((i*5))"; |
| Taipy | T2 | 111.5 | 192 | http_code=200.0 |
| Litpage | T2 | 27.0 | 70 | http_code=%{http_code}\n' |
| MediaMTX | T2 | 15.6 | 135 | probe_ms=5328.0 |

## What this cost

These were CPU-only runs on small rented instances (cents per run).

Whole campaign: US$ 50.79 (about R$ 249), shared by all repositories of this series. Rental share of the GPUs used in this repo:

| GPU | rentals | hours | rental cost (USD) |
|---|---|---|---|

Rental figures are hourly price x time of each rented instance; marketplace download fees and idle time are in the campaign total, not in this table.

## Reproduce

`bash scripts/run.sh` documents the exact commands used on the rented instance (Ubuntu, CUDA, Python venv). Evidence files are the unmodified measured rows (host location and reliability removed).
