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


clockPulse = false
tState = 0
controlWord = 0
opcode = 0
ticks = 0
function onTick()
    clockspeed = input.getNumber(2)
    if input.getBool(1) == false then
        return
    end

    if ticks >= clockspeed then
        clockPulse = true
        ticks = 0

        tState = tState + 1
        if tState > 12 then
            tState = 1
        end

        if tState <= 6 then
            controlWord = tState
        end
        if tState == 6 then
            opcode = input.getNumber(3)
        end
        if tState >= 7 then

            if opcode == 0 then
                tState = 0
            end
            if opcode == 1 then
                controlWord = tState - 6
            end

        end
        if tState == 10 then

            if opcode == 1 then
                controlWord = 7
            end

        end

    end

    output.setBool(1, clockPulse)
    output.setNumber(2, controlWord)

    clockPulse = false
    ticks = ticks + 1
end