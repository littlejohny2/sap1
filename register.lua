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

programCounter = 0
instructionRegister = 0

register = {}
for letter = 1, 4 do
    register[letter] = 0
end


outputWord = 0
function onTick()
    clockPulse = input.getBool(1)
    controlWord = input.getNumber(2)
    ramInput = input.getNumber(3)

    if clockPulse == true then

        if controlWord == 1 then
            programCounter = programCounter+1
            if programCounter > 16384 then
                programCounter = 0
            end
        end
        if controlWord == 2 then
            outputWord = programCounter
        end
        if controlWord == 4 then
            instructionRegister = ramInput
        end
        if controlWord == 5 then
            outputWord = instructionRegister
        end
        if controlWord >= 7 and controlWord <= 10 then
            register[controlWord - 6] = ramInput
        end
        if controlWord >= 11 and controlWord <= 13 then
            register[controlWord - 9] = register[1]
        end
        if controlWord == 14 then
            register[1] = register[2]
        end
        if controlWord == 15 or controlWord == 16 then
            register[controlWord - 12] = register[2]
        end
        if controlWord == 17 or controlWord == 18 then
            register[controlWord - 16] = register[3]
        end
        if controlWord == 19 then
            register[4] = register[3]
        end
        if controlWord >= 20 and controlWord <= 22 then
            register[controlWord - 19] = register[4]
        end

    end

    output.setNumber(1, outputWord)

    -- debug --
    output.setNumber(2, register[1])
    output.setNumber(3, register[2])
    output.setNumber(4, register[3])
    output.setNumber(5, register[4])
    output.setNumber(6, instructionRegister)
    output.setNumber(7, programCounter)
end