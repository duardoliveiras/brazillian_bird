PipePair = Class{}

local GAP_HEIGHT = 85
-- tamanho de espaco livre entre os tubos

function PipePair:init(y)

    self.x = VIRTUAL_WIDTH + 32
    -- inicia os tubos 32px alem da borda da tela

    self.y = y
    -- valor y para o tubo superior...
    -- ao somar o espaco vazio 'GAP' e o tamanho do tubo 'HEIGHT' temos
    -- o y do tubo inferior

    self.pipes = {
        ['upper'] = Pipe('top',self.y),
        ['lower'] = Pipe('bottom', self.y + PIPE_HEIGHT + GAP_HEIGHT)
        -- iniciliza os dois tubo, superior e inferior como um array
    }

    self.remove = false 
    -- diz que o par de tubos nao pode ser removido ainda 
    -- gerando uma otimizacao na hora de apagar o tubo apos ele passar a borda
    self.scored = false
end

function PipePair:update(dt)

    if self.x > - PIPE_WIDTH then
        self.x = self.x + PIPE_SCROLL * dt
        self.pipes['lower'].x = self.x
        self.pipes['upper'].x = self.x
    else
        self.remove = true
    end

end

function PipePair:render()
    for k, pipe in pairs(self.pipes) do
        pipe:render()
    end
end
