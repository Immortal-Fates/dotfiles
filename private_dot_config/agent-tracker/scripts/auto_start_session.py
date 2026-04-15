#!/usr/bin/env python3

import argparse
import json
import os
import shutil
import subprocess
import sys


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--source", required=True)
    parser.add_argument("--session-id", default="")
    parser.add_argument("--cwd", default="")
    parser.add_argument("--summary", default="")
    parser.add_argument("--task-id", default="")
    parser.add_argument("--parent-task-id", default="")
    parser.add_argument("--from-codex-hook", action="store_true")
    return parser.parse_args()


def read_codex_hook_payload() -> dict:
    try:
        raw = sys.stdin.read().strip()
        if not raw:
            return {}
        data = json.loads(raw)
        if isinstance(data, dict):
            return data
    except Exception:
        pass
    return {}


def build_summary(summary: str, session_id: str, cwd: str) -> str:
    summary = summary.strip()
    if summary:
        return summary
    if cwd:
        name = os.path.basename(os.path.abspath(cwd))
        if name:
            return f"session start - {name}"
    if session_id:
        return f"session start - {session_id[:8]}"
    return "session start"


def tracker_client_path() -> str:
    tracker_bin = shutil.which("tracker-client")
    if tracker_bin:
        return tracker_bin
    return os.path.join(
        os.path.expanduser("~"), ".config", "agent-tracker", "bin", "tracker-client"
    )


def main() -> int:
    args = parse_args()

    session_id = args.session_id.strip()
    cwd = args.cwd.strip()
    if args.from_codex_hook:
        payload = read_codex_hook_payload()
        session_id = str(payload.get("session_id", session_id)).strip()
        cwd = str(payload.get("cwd", cwd)).strip()

    tracker_bin = tracker_client_path()
    if not os.path.exists(tracker_bin):
        return 0

    summary = build_summary(args.summary, session_id, cwd)
    command = [
        tracker_bin,
        "command",
        "--source",
        args.source.strip(),
        "--task-id",
        args.task_id.strip(),
        "--parent-task-id",
        args.parent_task_id.strip(),
        "--summary",
        summary,
        "start_task",
    ]

    try:
        subprocess.run(
            command,
            cwd=cwd if cwd and os.path.isdir(cwd) else None,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
            check=False,
            timeout=10,
        )
    except Exception:
        return 0

    return 0


if __name__ == "__main__":
    sys.exit(main())
