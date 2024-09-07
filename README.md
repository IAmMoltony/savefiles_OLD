# savefiles (old)

**This repository is an archive of the old savefiles repo.**

**It does not contain any save files.**

**The original repository was deleted because I'm pretty sure storing save file backups on GitHub is against their terms of service and like I don't want to get banned off github or anything so yeah**

This is my repository for backing up game save files.

## Initial installation

Copy `user_EXAMPLE.json` as `user.json` in the repository directory. Then fill in
your game paths (see below) and your machine name (used for separating different
machines' save file backups).

## Usage

The backup tool can be used as a CLI and as a GUI.

### CLI

To use the CLI, run the `backup.py` script in your terminal. To back up all
your games, run `./backup.py backup`, and to back up a specific game, run
`./backup.py backup -g (game name here)`.

### GUI

To start the GUI, run `./backup.py gui` and then it will show up. Using the
GUI is very straightforward from there.

If you want to add the GUI to your application menu or on your desktop,
there is a desktop entry available (see `sfgui.desktop`).

**Important**: when using the desktop entry, make sure to replace the path to
the `backup.py` script, the icon and working directory to point to your copy of
the repository.

## Configuration

All configuration is done via the `user.json` file. See `User.md` for more
information.

## Automatic backup

Backups of games can be run automatically. Add `autobackup.sh` to your crontab
or something, and that's all you have to do.

### Usage

Run the `autobackup.sh` script, it'll take care of everything.

## Supported games

- Minecraft (`Minecraft`)
- Touhou 6: the Embodiment of Scarlet Devil (`Touhou06`)
- Touhou 7: Perfect Cherry Blossom (`Touhou07`)
- Touhou 8: Imperishable Night (`Touhou08`)
- Touhou 18: Unconnected Marketeers (`Touhou18`)
- Baba Is You (`BabaIsYou`)
- Super Tux (`SuperTux`)
- Forager (`Forager`)
- Peggle (`Peggle`)
- Animal Crossing (`AnimalCrossingGCNDolphin`)
- Terraria (`Terraria`)

If you'd like to request support for a game, don't hesitate to open a GitHub
issue about it.

## Adding support for new games

Adding support for new games is quite simple.

1. Create a `backupper_game.py`, replace `game` with the name of the game.
1. Add the following code (do not forget to replace the game name):
   ```python
   from backupper import Backupper

   class GameBackupper(Backupper): # <-- Replace the game name!
       def __init__(self, paths: dict[str], machine_name: str):
           super().__init__(paths, machine_name, "GameName") # <-- Replace the game name!

       def backup(self):
           # This is where the actual backup procedure happens
           # Example:
           self.copyall() # Copy all files from the save directory to the repo
           # See section "API reference" below
   ```
1. Add your backupper to `backuppers.py`:
   1. Add an import line at the top (replace the game name):
      ```python
      from backupper_game import GameBackupper
      ```
   1. Add it to the list of backuppers (do not forget to replace the game name):
      ```python
      BACKUPPERS = {
          # ... other games ...
          "GameName": GameBackupper
      }
      ```
1. Optionally, add it to `user.json`.

### Emulated games

If the game can be emulated using multiple emulation programs and their save file
format is incompatible, create multiple backuppers inside one file.

For this example, I'll write a backupper for a theoretical game called
*Super Cirno 4* that runs on an, again, theoretical system called
*Gaming Box*. The system has two emulators: *mtnbox* and *Orange*.

This is what `backupper_supercirno4.py` would look like:

```python
from backupper import Backupper


class SuperCirno4MtnboxBackupper(Backupper):
    def __init__(self, paths: dict[str], machine_name: str, config: dict):
        super().__init__(paths, machine_name, "SuperCirno4Mtnbox", config)

    def backup(self):
        self.copyfile("save_SCR4_3453.mbs")

class SuperCirno4OrangeBackupper(Backupper):
    def __init__(self, paths: dict[str], machine_name: str, config: dict):
        super().__init__(paths, machine_name, "SuperCirno4Orange", config)

    def backup(self):
        self.copydir("SCR4")
```

## API reference

There are multiple functions for save file backup.

______________________________________________________________________

```python
self.copyall()
```

Copy anything and everything from the save file folder.

Example:

```python
def backup(self):
    self.copyall() # copy everything!!!
```

______________________________________________________________________

```python
self.copydir(directory)
```

Copy a specific directory from the save file folder.

Example:

```python
def backup(self):
    self.copydir("replay") # Copy all files from the replay folder
```

______________________________________________________________________

```python
self.copydirwc(pattern)
```

Copy directories from the save file directory that follow a certain pattern.

Example:

```python
def backup(self):
    self.copydirwc("profile*") # Copy all directories that start with `profile`
```

______________________________________________________________________

```python
self.copyfilewc(pattern)
```

Copy files from the save file directory that follow a certain pattern.

Example:

```python
def backup(self):
    self.copyfilewc("SaveFile_*.qwe") # Copy all files that start with `SaveFile_` and end with `.qwe`
```

______________________________________________________________________

```python
self.copyfile(file)
```

Copy a specific file from the save file directory.

Example:

```python
def backup(self):
    self.copyfile("score.txt") # Copy score.txt and nothing else
```

______________________________________________________________________

```python
self.listdir(dir)
```

List contents of a subdirectory in the save file directory.

If failed to list contents of the directory, returns `False`.

Example:

```python
def backup(self):
    save_files = self.listdir("saves")
    print(save_files)
```
