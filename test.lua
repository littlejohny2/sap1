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


--[====[ EDITABLE SIMULATOR CONFIG - *automatically removed from the F7 build output ]====]
---@section __LB_SIMULATOR_ONLY__
do
    ---@type Simulator -- Set properties and screen sizes here - will run once when the script is loaded
    simulator = simulator
    simulator:setScreen(1, "2x2")
    simulator:setProperty("ExampleNumberProperty", 123)

    -- Runs every tick just before onTick; allows you to simulate the inputs changing
    ---@param simulator Simulator Use simulator:<function>() to set inputs etc.
    ---@param ticks     number Number of ticks since simulator started
    function onLBSimulatorTick(simulator, ticks)

        -- touchscreen defaults
        local screenConnection = simulator:getTouchScreen(1)
        simulator:setInputBool(1, screenConnection.isTouched)
        simulator:setInputNumber(1, screenConnection.width)
        simulator:setInputNumber(2, screenConnection.height)
        simulator:setInputNumber(3, screenConnection.touchX)
        simulator:setInputNumber(4, screenConnection.touchY)

        -- NEW! button/slider options from the UI
        simulator:setInputBool(31, simulator:getIsClicked(1))       -- if button 1 is clicked, provide an ON pulse for input.getBool(31)
        simulator:setInputNumber(31, simulator:getSlider(1))        -- set input 31 to the value of slider 1

        simulator:setInputBool(32, simulator:getIsToggled(2))       -- make button 2 a toggle, for input.getBool(32)
        simulator:setInputNumber(32, simulator:getSlider(2) * 45)   -- set input 32 to the value from slider 2 * 45
    end;
end
---@endsection


--[====[ IN-GAME CODE ]====]

-- try require("Folder.Filename") to include code from another file in this, so you can store code in libraries
-- the "LifeBoatAPI" is included by default in /_build/libs/ - you can use require("LifeBoatAPI") to get this, and use all the LifeBoatAPI.<functions>!

function onTick()
    controlWord = input.getNumber(1)
    ramOutput = input.getNumber(2)
    registerA = input.getNumber(3)
    registerB = input.getNumber(4)
    registerC = input.getNumber(5)
    registerD = input.getNumber(6)
    instructionRegister = input.getNumber(7)
    programCounter = input.getNumber(8)
end

function onDraw()
    width = screen.getWidth()
    height = screen.getHeight()

    screen.drawText(0, 0, 'contWord: ')
    screen.drawText(45, 0, tostring(controlWord))

    screen.drawText(0, 6, 'ram: ')
    screen.drawText(45, 6, tostring(ramOutput))

    screen.drawText(0, 12, 'regA: ')
    screen.drawText(45, 12, tostring(registerA))

    screen.drawText(0, 18, 'regB: ')
    screen.drawText(45, 18, tostring(registerB))

    screen.drawText(0, 24, 'regC: ')
    screen.drawText(45, 24, tostring(registerC))

    screen.drawText(0, 30, 'regD: ')
    screen.drawText(45, 30, tostring(registerD))

    screen.drawText(0, 36, 'instReg: ')
    screen.drawText(45, 36, tostring(instructionRegister))

    screen.drawText(0, 42, 'counter: ')
    screen.drawText(45, 42, tostring(programCounter))

end
