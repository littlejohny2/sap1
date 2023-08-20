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
    simulator:setScreen(1, "3x3")
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
        simulator:setInputNumber(32, simulator:getSlider(2) * 50)   -- set input 32 to the value from slider 2 * 50
    end;
end
---@endsection


--[====[ IN-GAME CODE ]====]

-- try require("Folder.Filename") to include code from another file in this, so you can store code in libraries
-- the "LifeBoatAPI" is included by default in /_build/libs/ - you can use require("LifeBoatAPI") to get this, and use all the LifeBoatAPI.<functions>!

RES = 0
CLK = 0
CLR = 0

Cp = 0
Ep = 0
Lm = 0
CE = 0

Li = 0
Ei = 0
La = 0
Ea = 0

Su = 0
Eu = 0
Lb = 0
Lo = 0


tState = 1

ticks = 0
function onTick()
    if input.getBool(1) == true then
        CLK = 0
        CLR = 0
        tState = 1
        return
    end


    CLK = 0
    ticks = ticks + 1


    if ticks >= 30 then

        -- clock --
        CLK = 1
        if CLR == 1 then
            CLR = 0
        else
            CLR = 1
        end

        -- print(CLR)
        ticks = 0



        -- t state counter --
        if CLR == 0 then

            tState = tState + 1
            if tState > 6 then
                tState = 1
            end

        end


        -- control word creation --
        opcode = input.getNumber(2)

        RES = 0

        Cp = 0
        Ep = 0
        Lm = 0
        CE = 0

        Li = 0
        Ei = 0
        La = 0
        Ea = 0

        Su = 0
        Eu = 0
        Lb = 0
        Lo = 0

        if tState == 1 then
            Ep = 1
            Lm = 1
        end
        if tState == 2 then
            Cp = 1
        end
        if tState == 3 then
            CE = 1
            Li = 1
        end
        if tState == 4 then

            if opcode == 0 or opcode == 1 or opcode == 2 then
                Ei = 1
                Lm = 1
            end
            if opcode == 14 then
                Ea = 1
                Lo = 1
            end
            if opcode == 15 then
                RES = 1
            end

        end
        if tState == 5 then

            if opcode == 0 then
                CE = 1
                La = 1
            end
            if opcode == 1 then
                CE = 1
                Lb = 1
            end
            if opcode == 2 then
                CE = 1
                Lb = 1
                Su = 1
            end
            if opcode == 15 then
                RES = 1
                output.setBool(2, true)
            end

        end
        if tState == 6 then

            if opcode == 1 then
                Eu = 1
                La = 1
            end
            if opcode == 2 then
                Eu = 1
                La = 1
                Su = 1
            end

        end


    end



    -- output --
    controlWord = (Lo*2^0)+(Lb*2^1)+(Eu*2^2)+(Su*2^3)+(Ea*2^4)+(La*2^5)+(Ei*2^6)+(Li*2^7)+(CE*2^8)+(Lm*2^9)+(Ep*2^10)+(Cp*2^11)+(CLR*2^12)+(CLK*2^13)+(RES*2^14)

    output.setNumber(1, controlWord)

end