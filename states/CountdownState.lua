

CountdownState = Class{__includes = BaseState}


COUNTDOWN_TIME = 0.75

function CountdownState:init()
    self.count = 3
    self.time = 0
end


function CountdownState:update(dt)
    self.time = self.time+dt
    if self.time > COUNTDOWN_TIME then
        self.time = self.time % COUNTDOWN_TIME
        self.count = self.count - 1

        if self.count == 0 then
            gStateMachine:change('play')
        end
    end
end

function CountdownState:render()
    love.graphics.setFont(bigFont)
    love.graphics.printf(tostring(self.count),0,136,VIRTUAL_WIDTH,'center')
end
