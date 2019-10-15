#!/usr/bin/env python3
"""
Editor script to create a component for the provided resource
"""
from os.path import exists

_log_file = "python_log.txt"

if exists(_log_file):
    import sys
    import traceback

    def log_exception(a, b, tb):
        with open("python_log.txt", "a") as fp:
            traceback.print_tb(tb, file=fp)

    sys.stdout = open("python_log.txt", 'w')
    sys.excepthook = log_exception

from pathlib import Path
import deftree
import sys


def _fix_path(path):
    _anchor = Path("/").anchor
    """We have to remove the anchor if there is one"""
    if path.anchor == _anchor:
        path = Path(str(path)[1:])
    return Path().cwd() / path


def atlas(atlas_path, paths):
    tree = deftree.parse(atlas_path)
    root = tree.get_root()

    for path in paths:
        images = deftree.Element("images")
        root.insert(-4, images)
        images.add_attribute("image", path.as_posix())

    tree.write()


def main(paths):
    """Find the atlas among the input arguments"""
    atlas_path = None
    paths = [Path(p) for p in paths]
    for path in paths[::-1]:
        if path.suffix == ".atlas":
            if atlas_path is not None:
                sys.exit()  # Atlas already found, not allowed
            atlas_path = _fix_path(path)
            paths.remove(path)
    if atlas_path:
        atlas(atlas_path, paths)


if __name__ == '__main__':
    main(sys.argv[1:])
