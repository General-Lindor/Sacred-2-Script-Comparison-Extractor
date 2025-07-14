Extractor to compare and extract differences between the lua scripts of two different versions of Sacred 2.

usage: just put the scripts of one version into ORIGINAL/ and one into MODIFIED/ and start the exe, it will extract the differences.
only works on windows OS for now.

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