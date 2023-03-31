

ScoreState = Class{__includes = BaseState}

function ScoreState:enter(params)
    self.score = params.score
end


    function ScoreState:update(dt)
        if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
            gStateMachine:change('countdown')
        end
    end

function ScoreState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf("Voce Perdeu!",0,100,VIRTUAL_WIDTH,'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf("Score: " .. tostring(self.score),0,136,VIRTUAL_WIDTH,'center')

    love.graphics.printf("Pressione Enter para Jogar Novamente",0,164,VIRTUAL_WIDTH,'center')
end