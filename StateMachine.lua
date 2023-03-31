StateMachine = Class{}


function StateMachine:init(states)
    self.empty = {
        render = function() end,
        update = function() end,
        enter = function() end,
        exit = function() end
    }

    self.states = states or {} -- se a entrada for states, = states, caso nao, inicia vazio
    self.current = self.empty
end


function StateMachine:change(stateName, enterParam)
    assert(self.states[stateName]) -- verifica se o state existe e retorna um true ou false
    self.current:exit()
    self.current = self.states[stateName]()
    self.current:enter(enterParam)
end

function StateMachine:render()
    self.current:render()
end

function StateMachine:update(dt)
    self.current:update(dt)
end

