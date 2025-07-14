Extractor to compare and extract differences between the lua scripts of two different versions of Sacred 2.

can extract:
    - behaviour.txt
    - client
        - animation.txt
        - soundprofile.txt
        - surface.txt
    - server
        - balance.txt
        - blueprint.txt
        - creatures.txt
        - drop.txt
        - equipsets.txt
        - faction.txt
        - pathObjects.txt
        - portals.txt
        - region.txt
        - triggerarea.txt
        - triggervolumes.txt
        - waypoints.txt
        - weaponpool.txt
        - worldobjects.txt
    - shared
        - books.txt
        - creatureinfo.txt
        - iteminfo.txt
        - itemtype.txt
        - material.txt
        - spells.txt
        - typification.txt

cannot extract:
    - the particle files
    - autoexec.txt
    - server
        - questscripts.txt
        - quest.txt
        - respawn.txt
        - spawn.txt
        - spawnpos.txt
        - treasure.txt
        - weather.txt
        - worldobjecthints.txt
    - shared
        - defines.txt
        - staticinfo.txt

Note:
The files that can be extracted are a whitelist.
Any files not listed under "can extract" cannot be extracted.
The files listed under "cannot extract" refer to files which will never be able to be extracted even in future versions of this tool,
due to programmatical limitations. It does NOT mean that it might be able to extract files not listed under "cannot extract".