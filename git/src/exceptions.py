# -*- coding: utf-8 -*-
from typing import Optional


class NotValidUserInfoVariables(TypeError):
    def __init__(self, info: Optional[str]):
        self.info = info

    def __str__(self) -> str:
        return str(self.info)


class CantReadConfigGit(IOError):
    def __init__(self, info: Optional[str], sub_error: Exception):
        self.info = info
        self.sub_error = sub_error

    def __str__(self) -> str:
        return f"{self.info} Details: {self.sub_error}"
