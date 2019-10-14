"""
Editor script to create a component for the provided resource
"""
from pathlib import Path
import deftree
import sys

# If we need to do some debug printing
sys.stdout = open(Path("python_log.txt"), 'w')

_anchor = Path("/").anchor
def _fix_path(path):
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
    print("Arguments", sys.argv)
    main(sys.argv[1:])

