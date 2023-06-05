import json
from click import  command, option
from pathlib import Path
from enum import Enum
from pydantic import BaseModel
from typing import Callable, Dict, Tuple

class LanguagesEnum(Enum):
    PYTHON="PYTHON"
    JULIA="JULIA"

class KernelSpec(BaseModel):
    display_name: str
    language: str
    name: str

class LanguageInfo(BaseModel):
    file_extension: str
    mimetype: str
    name: str
    version: str

def python_conf() -> Tuple[KernelSpec, LanguageInfo]:
    spec = KernelSpec(
            display_name="Python 3 (ipykernel)",
            language="python",
            name="python3"
            )
    info = LanguageInfo(
            file_extension=".py",
            mimetype="text/x-python",
            name="python",
            version="3.9.16"
            )
    return spec, info

def julia_conf() -> Tuple[KernelSpec, LanguageInfo]:
    spec = KernelSpec(
            display_name="Julia 1.8.1",
            language="julia",
            name="julia-1.8"
            )
    info = LanguageInfo(
            file_extension=".jl",
            mimetype="application/julia",
            name="julia",
            version="1.8.1"
            )
    return spec, info

@command
@option("--notebook_path", type=Path)
@option("--lang", type=LanguagesEnum)
def main(notebook_path: Path, lang: LanguagesEnum):
    confs: Dict[
            LanguagesEnum, Callable[[], Tuple[KernelSpec, LanguageInfo]]
            ] = {
                    LanguagesEnum.PYTHON: python_conf,
                    LanguagesEnum.JULIA: julia_conf
                    }
    spec, info = confs[lang]()
    with open(notebook_path) as f:
        nb = json.load(f)
    nb["metadata"]["kernelspec"] = spec.dict()
    nb["metadata"]["language_info"] = info.dict()

    with open(notebook_path, "w") as f:
        json.dump(nb, f)
