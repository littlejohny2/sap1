-- Author: <Authorname> (Please change this in user settings, Ctrl+Comma)
-- GitHub: <GithubLink>
-- Workshop: <WorkshopLink>
--
--- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--- If you have any issues, please report them here: https://github.com/nameouschangey/STORMWORKS_VSCodeExtension/issues - by Nameous Changey


--[====[ HOTKEYS ]====]
-- Press F6 to simulate this file
-- Press F7 to build the project, copy the output from /_build/out/ into the game to use
-- Remember to set your Author name etc. in the settings: CTRL+COMMA


--[====[ IN-GAME CODE ]====]

-- try require("Folder.Filename") to include code from another file in this, so you can store code in libraries
-- the "LifeBoatAPI" is included by default in /_build/libs/ - you can use require("LifeBoatAPI") to get this, and use all the LifeBoatAPI.<functions>!

ram = {}
for address = 0, 15 do
    ram[address] = 0
end
ram[1] = 1      -- MOV regA, 0xF
ram[2] = 15
ram[3] = 0      -- NOP

outputWord = 0
function onTick()
    clockPulse = input.getBool(1)
    controlWord = input.getNumber(2)
    addressInput = input.getNumber(3)

    if clockPulse == true and controlWord == 3 then

        outputWord = ram[addressInput]

    end

    output.setNumber(1, outputWord)
end