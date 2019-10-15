#!/usr/bin/env python3
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

import sys
from pathlib import Path
import deftree


def _fix_path(path):
    """We have to remove the anchor if there is one"""
    _anchor = Path("/").anchor
    if path.anchor == _anchor:
        path = Path(str(path)[1:])
    return Path().cwd() / path


def sort_atlas(path):
    tree = deftree.parse(path)
    root = tree.get_root()
    new_tree = deftree.DefTree()
    new_root = new_tree.get_root()
    _atlas = []
    _animations = []

    for at in root.iter_elements("images"):
        _atlas.append(at.get_attribute("image").value)

    for ani in root.iter_elements("animations"):
        _animations.append(ani)

    # Sort the images
    for a in sorted(_atlas, key=lambda x: x.split("/")[-1]):
        ele = new_root.add_element("images")
        ele.add_attribute("image", a)

    # Add the animations
    for animation in _animations:
        new_root.append(animation)

    # Add the atlas attributes. Margin, extrude
    for at in root.attributes():
        if not at.name == "image":
            new_root.append(at)

    new_tree.write()

def main(path):
    path = _fix_path(Path(path))
    sort_atlas(path)

if __name__ == '__main__':
    main(sys.argv[-1])
