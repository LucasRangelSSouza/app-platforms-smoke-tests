import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
S = json.loads((ROOT / "results" / "summary.json").read_text())


def test_all_platforms_came_up():
    assert S["tools_with_success"] == S["tools"] == 4


def test_http_checks_returned_200():
    assert S["m_taipy_http_code"] == 200 and S["m_litpage_http_code"] == 200


def test_mediamtx_probe_time_is_recorded():
    assert S["m_mediamtx_probe_ms"] > 0
