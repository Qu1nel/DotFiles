import os
from pathlib import Path
from typing import TypeAlias
import json

from misc.exceptions import CantReadConfigGit, NotValidUserInfoVariables

ValuesParameters: TypeAlias = str | bool | dict[str, str]
Parameters: TypeAlias = dict[str, dict[str, ValuesParameters]]


def read_git_config_as_dict() -> dict[str, Parameters]:
    """Read raw git config from './git_config.toml' and try return his as dict.

    The function tries to read the file './git_config.toml' and returns it as a
    dictionary of a certain structure or raises a CantReadConfigGit exception.

    Returns:
        dict[str, Parameters]: Some struct of dict.

    Raises:
        CantReadConfigGit: Will be called on any error caused by
            IOError or TomlDecodeError.
    """
    try:
        path_to_config_for_git = Path(__file__).parent.with_name("config.json")
        with open(path_to_config_for_git, mode="r", encoding="UTF-8") as config_json:
            data = json.load(config_json)
    except (IOError, json.JSONDecodeError) as exc:
        raise CantReadConfigGit("Cannot read a config file.", sub_error=exc) from None

    return data


def get_env_variables() -> tuple[str, str, str]:
    """Get user information variables from 'os.getenv()'.

    The function returns a sequence of variables about the user in the form
    of a tuple or raises an exception.

    Returns:
        Sequence[str]: Tuple of variables.

    Raises:
        NotValidUserInfoVariables: if at least one variable has not been set
            and is an empty string.
    """
    # Getting the variables that were set in setup.sh
    NAME = os.getenv("NAME")
    EMAIL = os.getenv("EMAIL")
    NICKNAME = os.getenv("NICKNAME")

    if (NAME is None) or (EMAIL is None) or (NICKNAME is None):
        raise NotValidUserInfoVariables(
            "The variables NAME or EMAIL or NICKNAME have not been initialized "
            "and cannot be used as valid data for the git config."
        )
    returns = (NAME, EMAIL, NICKNAME)
    return returns


def get_template_path(name_template_file: str) -> Path:
    """Get path git template file.

    Depending on the presence of the GIT_CONFIG_GLOBAL variable, the path to the
    file is configured <name_template_file>.

    Args:
        name_template_file (str): The file name of template.

    Returns:
        Path: a complete path to template git commit message.
    """
    if GIT_CONFIG_GLOBAL := os.getenv("GIT_CONFIG_GLOBAL"):
        return Path(GIT_CONFIG_GLOBAL).with_name(name_template_file)
    else:
        return Path().home().with_name(name_template_file)
