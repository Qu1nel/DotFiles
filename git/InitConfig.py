#!/c/pythons/Python311/python311.exe
import os
from typing import Optional, IO
from functools import partial


TARGET_FILE_NAME = '.gitconfig'
ALIASES_FILE_PATH = 'aliases'
HOME = os.getenv("HOME")
NAME = os.getenv("NAME")
EMAIL = os.getenv("EMAIL")
NICK = os.getenv("NICK")

if HOME is None:
    raise ValueError("The enviroment variable \"HOME\" is missing!")

if NAME is None:
    raise ValueError("The enviroment variable \"NAME\" is missing!")

if EMAIL is None:
    raise ValueError("The enviroment variable \"EMAIL\" is missing!")

if NICK is None:
    raise ValueError("The enviroment variable \"NICK\" is missing!")

FULL_PATH_TO_CONFIG = os.path.join(HOME, TARGET_FILE_NAME)

DATA: dict[str, dict[str, dict[str, str] | Optional[str] | bool]] = {
    "user": {
        "name": NAME,
        "email": EMAIL, 
        "username": NICK
    },
    "init": {
        "defaultBranch": "main"
    },
    "pull": {
        "rebase": True
    },
    "fetch": {
        "prune": True
    },
    "core": {
        "editor": "$EDITOR",
        "whitespace": "fix,-indent-with-non-tab,trailing-space,cr-at-eol",
        "quotepath": False
    },
    "credential": {
        "helper": "cache --timeout 1800"
    },
    "color": {
        "ui": "auto",
        "diff": "auto",
        "status": "auto",
        "branch": "auto",
        "$status": {
            "added": "green",
            "changed": "yellow",
            "untracked": "red"
        },
        "$branch": {
            "current": "green",
            "local": "yellow",
            "remote": "red"
        },
        "$diff": {
            "meta": "yellow bold",
            "frag": "magenta bold",
            "old": "red bold",
            "new": "green bold",
            "whitespace": "red reverse"
        }
    },
    "merge": {
        "tool": "nvimdiff2"
    },
    "diff": {
        "tool": "nvimdiff"
    }
}


def write_info_into_file(file: IO) -> None:
    write_print = partial(print, file=file, flush=True)

    for field in DATA:
        write_print(f"[{field}]")

        for setting, value in DATA[field].items():
            if isinstance(value, dict) and setting.startswith("$"):
                write_print(f"[{field} \"{setting[1:]}\"]")

                for sub_setting, sub_value in value.items():
                    write_print(f"\t{sub_setting} = {sub_value}")

            else:
                value = str(value).lower() if type(value) is bool else value
                write_print(f"\t{setting} = {value}")


def write_aliases_into_file(file: IO) -> None:
    write_print = partial(print, file=file, flush=True)

    write_print("[alias]")

    with open(ALIASES_FILE_PATH, encoding='UTF-8') as f:
        while (line := f.readline()):
            if line.startswith('\n') or line.startswith('#'):
                continue
                
            if '#' in line:
                line = line[:line.find('#')]
            
            write_print(f"\t{line.strip()}")


def main(file_name: str) -> None:
    with open(file_name, mode='w', encoding='UTF-8') as f:
        write_info_into_file(f)
        write_aliases_into_file(f)


if __name__ == '__main__':
    main(FULL_PATH_TO_CONFIG)
