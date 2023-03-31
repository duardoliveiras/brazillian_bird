push = require('push')
Class = require('class')
require 'Bird'
require 'Pipe'
require 'PipePair' 

require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/CountdownState'
require 'states/ScoreState'
require 'states/TitleScreenState'



WINDOW_WIDTH = 640
WINDOW_HEIGHT = 360

VIRTUAL_WIDTH = 511
VIRTUAL_HEIGHT = 288

-- variaval que armazena uma imagem
local background = love.graphics.newImage('background.png')
local ground = love.graphics.newImage('ground.png')

-- posicao do plano de fundo
local scrollBackground = 0
local scrollGround = 0 

--velocidade do plano de fundo
local BACKGROUND_SPD = 30
local GROUND_SPD = 60

local BACKGROUND_LOOPING_POINT = 511
-- ponto aonde comeca a renderizar de novo o background

local collision = false

function love.load()
    math.randomseed(os.time())

    love.graphics.setDefaultFilter('nearest','nearest')
    love.window.setTitle('Brazillian Bird')

    smallFont = love.graphics.newFont('font.ttf',8)
    mediumFont = love.graphics.newFont('flappy.ttf',14)
    flappyFont = love.graphics.newFont('flappy.ttf',28)
    bigFont = love.graphics.newFont('flappy.ttf',56)
    love.graphics.setFont(flappyFont)
    
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = true,
        fullscreen = false,
        vsync = true 
    }

)

gStateMachine = StateMachine {
    ['title'] = function () return TitleScreenState() end,
    ['countdown'] = function() return CountdownState() end,
    ['play'] = function() return PlayState() end,
    ['score'] = function() return ScoreState() end
}
gStateMachine:change('title')
   

love.keyboard.keysPressed = {} 
-- tabela que salva a teclas que foram pressionadas
-- iniciando ela vazia
 
end


function love.resize(w,h)
    push:resize(w,h)
end

-- comandos no jogo
function love.keypressed(key)

    love.keyboard.keysPressed[key] = true
    -- salva na tabela a tecla que foi pressionada

    if key == 'escape' then
        love.event.quit()
    end
end

-- funcao para verificar se alguma tecla ''key''  foi pressionada
function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

-- update do jogo // atualizacao
function love.update(dt)
    if collision == false then
    -- acrescenta a velocidade do scroll do plano de fundo, e quando chegar no looping_point volta a renderizar a partir de 0
    scrollBackground = (scrollBackground+BACKGROUND_SPD*dt) % BACKGROUND_LOOPING_POINT
    -- no caso do piso usando o virtual width 
    scrollGround = (scrollBackground+GROUND_SPD*dt) % VIRTUAL_WIDTH
    gStateMachine:update(dt)
    
    
end
    love.keyboard.keysPressed = {} 
    -- a cada atualizacao esvazia a tabela de teclas pressionadas
end

-- desenho do jogo
function love.draw()
    push:start() 

    -- aqui onde desenha o plano e o chao a partir do scroll
    -- dando uma sensacao de movimento, pois o plano e o chao de deslocam para a esquerda
    -- a partir do checkpoint ele volta desenhar do 0
    love.graphics.draw(background, -scrollBackground,0)
    gStateMachine:render()
    love.graphics.draw(ground, -scrollGround,VIRTUAL_HEIGHT-16)
    

    push:finish()
end

