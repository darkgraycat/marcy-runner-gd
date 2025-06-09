## TODO List:
- [x] Fix duplication of entities in LevelChunk
- [x] Add LevelChunk generation management in Level scene
- [x] Add UI bitmap font. Read: https://docs.godotengine.org/en/stable/tutorials/ui/gui_using_fonts.html#bitmap-fonts

- [ ] Add in-game UI elements and connect to game state

## Notes
#### Chunks autogeneration
To avoid weird chunk connections, lets follow the rules:
- First column should be minimum 2 blocks height
- Last 2 colums can be empty
- Last colums can contain connection tiles for 2 or lower height
