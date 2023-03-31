

TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end


function TitleScreenState:render()
    love.graphics.setFont(flappyFont)
    -- defino a fonte
    love.graphics.printf('Brazillian Bird',0,100,VIRTUAL_WIDTH,'center')
    -- titulo do jogo
    
    love.graphics.setFont(mediumFont)
    love.graphics.printf('Pressione Enter',0,136,VIRTUAL_WIDTH,'center')
end


