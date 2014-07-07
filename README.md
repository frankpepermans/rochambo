rochambo
========

Flex based rock-paper-scissors;
why Rochambo? according to wiki it is a synonym: http://en.wikipedia.org/wiki/Rock-paper-scissors

BUILD
=====
- make sure you are able to run Ant scripts

The project contains an ant build.xml.
When running this, please make sure to point to the correct Flex SDK folder on your local machine.
This project has been tested with Flex SDK 4.6.

CONFIG
======
By default, 3 game modes are available:
- classic rock-paper-scissors
- big bang theory's rock-paper-scissors-lizard-spock
- world cup, where rock, paper and scissors are replaced by Lionel Messi, Vincent Kompany and Bastian Schweinsteiger

You can remove or add game modes using the rules.json file found in the assets directory.

TEST
====
I have included a test suite under src/test/_suites_

This suite contains one test (as example), this test will load the rules.json and validate the contents.

A rule is valid when:
- it contains choices (RulesetAssets)
- it is balanced => this means that each choice must have an equal chance to win
- the win/los/tie matrix must have the correct size (rows, columns equal to the amount of choices)
- for every win, there must be a win message (i.e. rock crushes scissors)

Obviously, more tests could be added (i.e. UI)

CONTROLS
========
- Player vs CPU: player uses mouse to select
- Player vs Player: Player one uses mouse, player two uses numpad keys

DOCUMENTATION
=============
The ant build will also generate asdocs, to illustrate, I've documented the actors package (Actor, IActor, CPUActor, PlayerActor)