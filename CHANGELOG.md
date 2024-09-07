# savefiles changelog

Changelog for savefiles backup tools.

## 1.10.2

- Fixed crashing if `user.json` has a parse error
- `listdir` now returns `False` if failed to list directory

## 1.10.1

- Fixed crashing if GUI cannot be imported

## 1.10

- Added support for *Terraria*

## 1.9

- Added support for *Animal Crossing* using the *Dolphin* emulator
- Corrected dry-run behavior in `copyall`, `copydirwc` and `copyfilewc`

## 1.8.1

- Fixed bug

## 1.8

- Added support for *Peggle*.

## 1.7.1

- Added handling error when missing required options

## 1.7

- Added alternative save location

## 1.6

- Added dry-run mode
- Fixed Minecraft backupper crashing if there is no `IgnoreWorlds` entry in config
- Fixed crashing if no config found

## 1.5

- Added per-game config
- Added ignoring worlds in Minecraft backupper

## 1.4

- GUI: added button to edit `user.json`

## 1.3

- Added support for *Forager*

## 1.2

- Added support for *Touhou 8: Imperishable Night*
- Copying directory does not crash if directory is not found

## 1.1.1

- Fixed CLI not having correct exit code

## 1.1

- Added a GUI for easy use

## 1.0.1

- Add checking if `user.json` exists at startup

## 1.0

- Initial release
