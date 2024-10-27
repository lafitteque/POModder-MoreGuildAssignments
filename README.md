# More Guild Assignments

## Description

Adds 4 new Guils Assignments in the loadout giving you new challenges :

- Mine as fast as you can
- Explode the mines with new blocks.
- ?????
- Make friends, but be carefull not to let them steal you all your resources.


This mod is in Beta, please send me your feedback in the comments or by message.

Compatibility : this mod should be compatible with all other mods.
Note : some limitations can cause lag and visual delay for new tiles (max 0.2s delay), don't be surprise if you see a block changing its resources as soon as it appears.

## Mod Design Intentions

I wanted to add missions that feel different from the main game mode with new tiles, a bit of WTF, some chill and obviously fun.


## Modding structure and strategy

Instead of overwriting Tile.gd in the main game, which causes compatibility issues, I chose to retrieve the information from the tiles every 0.2s and depending on the information retrieved, apply the desired changes. 
This causes lots of usless calls and is definitly the opposite of optimised. In addition, this causes all the mod actions to happen at most 0.2s after the moment they should occur. 
