Bird = Class{}

local GRAVITY = 4


function Bird:init()
    self.image = love.graphics.newImage('bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = (VIRTUAL_WIDTH/2) - (self.width/2)
    self.y = (VIRTUAL_HEIGHT/2) - (self.height/2)
    self.angulo = 0.0001
    self.down = true
    self.dy = 0
end

function Bird:render()
    
    love.graphics.draw(self.image, self.x, self.y, math.deg(self.angulo))

end

function Bird:collides(pipe)
    if (self.x) + (self.width - 2) >= pipe.x 
    and (self.x + 2) <= pipe.x + PIPE_WIDTH then -- colisao em x
        if (self.y) + (self.height) >= pipe.y 
        and self.y + 2 <= pipe.y + PIPE_HEIGHT then -- colisao em y
            return true
        end
    end 
    return false
end


function Bird:update(dt)
    self.dy = self.dy + GRAVITY * dt
    self.down = true

    -- verifica la na funcao main se a tecla pressionada foi o espaco
    if love.keyboard.wasPressed('x') then
        -- se sim ele diz que o DY vale - gravity/5
        self.dy = -GRAVITY/5
        self.down = false
            if self.angulo > -0.025 then
                self.angulo = 0
                self.angulo = self.angulo - 3 * dt
            end -- se o angulo for maior que 0.020 atuliza o angulo
                -- gira o passarado para cima
        else
            if self.angulo < 0.010 and self.down == true then
            self.angulo = self.angulo + 0.030 * dt
            end
    end

    

    self.y = self.y + self.dy
end
