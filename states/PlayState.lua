

PlayState = Class{__includes = BaseState}

PIPE_SCROLL = -60
PIPE_HEIGHT = 288
PIPE_WIDTH = 70



function PlayState:init()
    self.bird = Bird()
    -- cria uma variavel referente a classe bird
    self.pipePairs = {}
    -- crio um arraylist que salva pares de tudo
    self.spawnTimer = 0
    -- variavel apra controle de spawn dos pipes
    self.score = 0
    -- variavel pontuacao
    self.lastY = -PIPE_HEIGHT + math.random(80) + 20
    -- inicializa o ultimo valor de Y registrado, para basear os proximos tubos
end





function PlayState:update(dt)
    self.spawnTimer = self.spawnTimer + dt
    -- incremento a variavel de controle de tempo

    if self.spawnTimer > 3 then -- quando passar 3 segundos insira um pipe no jogo
       -- modifique a ultima coordenada Y que colocamos para que as folgas do tubos nao fiquem
       -- muito distantes
       -- nao superior a 10 px abaixo da borda superior
       -- e nao inferior a um comprimento de intervalo de 90px da partir inferior
       local y = math.max(-PIPE_HEIGHT + 25, math.min(self.lastY + math.random(-50,50), 
       VIRTUAL_HEIGHT - 100 - PIPE_HEIGHT))
        
        self.lastY = y

       table.insert( self.pipePairs, PipePair(y))
       -- inerindo um Objeto PipePair no array pares de tubos
       self.spawnTimer = 0
    end

    for k, pair in pairs(self.pipePairs) do
        if not pair.scored then 
            if pair.x + PIPE_WIDTH < self.bird.x then
                self.score = self.score + 1
                pair.scored = true
            end
        end
    end
    

   self.bird:update(dt) 
    -- movimentacao da classe bird 

    for k, pair in pairs(self.pipePairs) do -- um for que verifica todas posicoes do array
       pair:update(dt)            -- se tiver dentro da tela atualiza
    
        -- verifica se ouve colisao com o par de tubo
        for l, pipe in pairs(pair.pipes) do
            if self.bird:collides(pipe) then
                 gStateMachine:change('score',{
                    score = self.score
                 })
            end
        end

    end

    if self.bird.y > VIRTUAL_HEIGHT - 15 then
        gStateMachine:change('score',{
            score = self.score
         })
    end
    if self.bird.y < -15 then
        gStateMachine:change('score',{
            score = self.score
         })
    end

    for k, pair in pairs(self.pipePairs) do
        if pair.remove == true then
            table.remove(self.pipePairs,k)
        end
    end
end


function PlayState:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end
    -- rendereziando os pipes antes do piso para ter uma sensacao de profundidade

    love.graphics.setFont(mediumFont)
    love.graphics.print("Score: " .. tostring(self.score),8,8)

   self.bird:render() -- rederizacao da classe bird 
end
