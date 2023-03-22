# -*- coding: utf-8 -*-
import os
import sys
from functools import partial
from pathlib import Path, PurePath
from typing import Final, TextIO

from exceptions import CantReadConfigGit, NotValidUserInfoVariables
from utils import get_env_variables, read_git_config_as_dict

PATH_TO_GIT_CONFIG: Final[Path] = Path(__file__).parent.with_name(".gitconfig")
PATH_TO_ALIASES_FILE: Final[Path] = Path(__file__).parent.with_name("aliases")
NAME_TEMPLATE_FILE: Final[str] = "commit_template_message.txt"

if GIT_CONFIG_GLOBAL := os.getenv("GIT_CONFIG_GLOBAL"):
    template_path = Path(GIT_CONFIG_GLOBAL).with_name(NAME_TEMPLATE_FILE)
else:
    template_path = Path().home().with_name(NAME_TEMPLATE_FILE)

TEMPLATE_PATH: Final[Path] = template_path

try:
    # get variables from setup.sh
    NAME, EMAIL, NICKNAME = get_env_variables()
except NotValidUserInfoVariables:
    print("Mistake! Git user information variables were not entered is setup.sh")
    sys.exit(-1)

try:
    # get config from 'git_config.toml'
    DATA = read_git_config_as_dict()
except CantReadConfigGit:
    print(
        "Mistake! The configuration file cannot be read due to "
        "the absence of the file or incorrect data in it."
    )
    sys.exit(-1)


def create_config_into_file(file: TextIO) -> None:
    write_into_config = partial(print, file=file, flush=True)

    # Write main settings in config
    for field in DATA:
        write_into_config(f"[{field}]")

        for setting, value in DATA[field].items():
            if isinstance(value, dict):
                write_into_config(f'[{field} "{setting}"]')

                for sub_setting, sub_value in value.items():
                    write_into_config(f"\t{sub_setting} = {sub_value}")
            else:
                if type(value) is bool:
                    valid_value = str(value).lower()
                elif value.startswith("$"):
                    valid_value = globals().get(value[1:]) or ""
                else:
                    valid_value = value

                entered_string = f"\t{setting.strip('_')} = {valid_value}"
                write_into_config(entered_string)

    write_into_config("[alias]")

    # Write aliases in config
    with open(PATH_TO_ALIASES_FILE, mode="r", encoding="UTF-8") as file_aliases:
        while line := file_aliases.readline():
            # Skip comment line
            if line.startswith("\n") or line.startswith("#"):
                continue

            # Strip comment in valid line
            if "#" in line:
                line = line[: line.find("#")]

            write_into_config(f"\t{line.strip()}")


def main(path_to_config: PurePath | str) -> None:
    with open(path_to_config, mode="w", encoding="UTF-8") as git_config:
        create_config_into_file(git_config)


if __name__ == "__main__":
    main(path_to_config=PATH_TO_GIT_CONFIG)
