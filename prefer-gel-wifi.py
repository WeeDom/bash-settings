#!/usr/bin/env python3

import os
import subprocess

from dotenv import find_dotenv, load_dotenv


def nmcli(*args: str) -> str:
    result = subprocess.run(
        ["nmcli", *args],
        check=True,
        capture_output=True,
        text=True,
    )
    return result.stdout.strip()


def load_env() -> None:
    dotenv_path = find_dotenv(usecwd=True)

    if dotenv_path:
        load_dotenv(dotenv_path, override=False)


def active_wifi() -> str:
    return nmcli(
        "-t",
        "-f",
        "ACTIVE,SSID",
        "device",
        "wifi",
    )


def visible_ssids() -> set[str]:
    output = nmcli(
        "-t",
        "-f",
        "SSID",
        "device",
        "wifi",
        "list",
        "--rescan",
        "yes",
    )
    return set(output.splitlines())


if __name__ == "__main__":
    load_env()

    ssid = os.environ["GEL_WIFI_SSID"]

    if f"yes:{ssid}" in active_wifi().splitlines():
        raise SystemExit(0)

    if ssid not in visible_ssids():
        raise SystemExit(0)

    nmcli("connection", "up", "id", ssid)
