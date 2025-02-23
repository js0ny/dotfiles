#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Append Electron argument (for wayland) to *.desktop files

import argparse
import configparser
import os

APPEND_ARG_FILE = "~/.dotfiles/platforms/linux/electron-flags.conf"


with open(os.path.expanduser(APPEND_ARG_FILE)) as f:
    APPEND_ARGS = list(map(str.strip, f.readlines()))

# for file in desktop_files:
#     config = configparser.ConfigParser()
#     config.read(file)


def append_arg(file):
    config = configparser.ConfigParser()
    config.read(file)
    try:
        exec_line = config["Desktop Entry"].get("Exec")
    except KeyError:
        print(f"Skipping {file} as it does not have an Exec key")
        return
    print(f"Appending {APPEND_ARGS} to {exec_line}")
    config["Desktop Entry"].update({"Exec": f"{exec_line} {' '.join(APPEND_ARGS)}"})
    with open(file, "w") as f:
        config.write(f)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-f", "--file", help="Desktop file to modify")
    args = parser.parse_args()
    append_arg(args.file)
    pass


if __name__ == "__main__":
    main()
