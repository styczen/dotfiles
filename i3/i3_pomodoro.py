#!/usr/bin/env python3

from enum import Enum
import json
import time
import socket
import sys
import subprocess


class State(Enum):
    IDLE = "idle"
    RUNNING = "running"
    STOPPED = "stopped"
    FINISHED = "finished"
    ERROR = "error"


def get_pomodoro_status() -> tuple[str, State]:
    try:
        with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as sock:
            sock.connect("/tmp/pomodoro.sock")
            sock.sendall(json.dumps({"command": "status"}).encode("utf-8"))
            r = json.loads(sock.recv(4096))
            log_to_file(json.dumps(r))
            if "status_line" not in r or "state" not in r:
                return "Pomodoro unavailable", State.ERROR
            state = State(r["state"].lower())
            return f'🍅 {r["formatted_time"]}', state
    except Exception:
        return "Pomodoro unavailable", State.ERROR


def print_line(message):
    """Non-buffered printing to stdout."""
    sys.stdout.write(message + "\n")
    sys.stdout.flush()


def read_line():
    """Interrupted respecting reader for stdin."""
    # try reading a line, removing any extra whitespace
    try:
        line = sys.stdin.readline().strip()
        # i3status sends EOF, or an empty line
        if not line:
            sys.exit(3)
        return line
    # exit on ctrl-c
    except KeyboardInterrupt:
        sys.exit()


def log_to_file(message):
    """Log a message to a file."""
    with open("/tmp/i3_echo.log", "a") as log_file:
        log_file.write(f"[{time.time_ns()}]: {message}\n")


if __name__ == "__main__":
    # Skip the first line which contains the version header.
    line = read_line()
    # log_to_file(line)
    print_line(line)

    # The second line contains the start of the infinite array.
    line = read_line()
    # log_to_file(line)
    print_line(line)

    notification_sent = False
    while True:
        line, prefix = read_line(), ""
        # ignore comma at start of lines
        if line.startswith(","):
            line, prefix = line[1:], ","

        status_line, state = get_pomodoro_status()
        if state == State.ERROR:
            color = "#ff0000"
        elif state == State.FINISHED:
            color = "#00ff00"
            if not notification_sent:
                notification_sent = True
                subprocess.run(
                    [
                        "notify-send",
                        "--urgency",
                        "normal",
                        "--expire-time",
                        "0",
                        "Pomodoro finished!",
                    ]
                )
        else:
            notification_sent = False
            color = "#ffffff"
        # log_to_file(status_line)
        obj = {
            "full_text": status_line,
            "color": color,
            "align": "center",
            "urgent": False,
        }
        j = json.loads(line)
        j.insert(0, obj)
        # and echo back new encoded json
        # log_to_file(json.dumps(j, indent=4))
        print_line(prefix + json.dumps(j))
