WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

Class = require 'class'
push = require 'push'

require 'Ball'
require 'Paddle'

function love.load()
    love.window.setTitle('AdiPong')
    math.randomseed(os.time())

    love.graphics.setDefaultFilter('nearest', 'nearest')

    audio = {
        ['paddle_hit'] = love.audio.newSource('audio/paddle_hit.wav', 'static')
    }

    smallFont = love.graphics.newFont('font.ttf', 8)
    scoreFont = love.graphics.newFont('font.ttf', 32)

    player1Score = 0
    player2Score = 0

    paddle1 = Paddle(5, 20, 5, 20)
    paddle2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 5, 5)

    gameState = 'start'

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    paddle1:update(dt)
    paddle2:update(dt)

    -- TODO

    if ball.x <= 0 then
        if isGamerOver() == false then
            player2Score = player2Score + 1
            ball:reset()
            ball.dX = -100
            gameState = 'serve'
        else
            player2Score = player2Score + 1
            ball:reset()
            ball.dX = math.random(2) == 1 and 100 or -100
            gameState = 'over'
        end
    end

    if ball.x >= VIRTUAL_WIDTH - 5 then
        if isGamerOver() == false then
            player1Score = player1Score + 1
            ball:reset()
            ball.dX = 100
            gameState = 'serve'
        else
            player1Score = player1Score + 1
            ball:reset()
            ball.dX = math.random(2) == 1 and 100 or -100
            gameState = 'over'
        end
    end

    if ball:collides(paddle1) then
        ball.dX = -ball.dX
        audio['paddle_hit']:play()
    end

    if ball:collides(paddle2) then
        ball.dX = -ball.dX
        audio['paddle_hit']:play()
    end

    if ball.y <= 0 then
        ball.dY = -ball.dY
        ball.y = 0
    end

    if ball.y >= VIRTUAL_HEIGHT - 5 then
        ball.dY = -ball.dY
        ball.y = VIRTUAL_HEIGHT - 5
    end


    if love.keyboard.isDown('w') then
        paddle1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        paddle1.dy = PADDLE_SPEED
    else
        paddle1.dy = 0
    end

    if love.keyboard.isDown('up') then
        paddle2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        paddle2.dy = PADDLE_SPEED
    else
        paddle2.dy = 0
    end

    if gameState == 'play' then
        ball:update(dt)
    end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()

    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' or gameState == 'serve' then
            gameState = 'play'
        elseif gameState == 'over' then
            player1Score = 0
            player2Score = 0
            gameState = 'play'
        end
    end
end

function love.draw()
    push:apply('start')
    -- Screen background rgb(19, 31, 41)
    love.graphics.clear(19 / 255, 31 / 255, 41 / 255, 1)

    -- Ball
    ball:render()

    -- Player paddles
    paddle1:render()
    paddle2:render()

    -- Display FPS
    displayFPS()

    -- Helper text
    if gameState == 'start' then
        love.graphics.printf('Welcome to Pong!', 0, 32, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press ENTER or RETURN to start', 0, 42, VIRTUAL_WIDTH, 'center')

    elseif gameState == 'serve' then
        if ball.dX == 100 then
            love.graphics.printf('Player 1 to serve.', 0, 32, VIRTUAL_WIDTH, 'center')
            love.graphics.printf('Press ENTER or RETURN', 0, 42, VIRTUAL_WIDTH, 'center')
        else
            love.graphics.printf('Player 2 to serve.', 0, 32, VIRTUAL_WIDTH, 'center')
            love.graphics.printf('Press ENTER or RETURN', 0, 42, VIRTUAL_WIDTH, 'center')
        end

    elseif gameState == 'over' then
        if player1Score == 10 then
            love.graphics.printf('Player 1 wins!', 0, 32, VIRTUAL_WIDTH, 'center')
            love.graphics.printf('Press ENTER or RETURN to restart', 0, 42, VIRTUAL_WIDTH, 'center')
        else
            love.graphics.printf('Player 2 wins!', 0, 32, VIRTUAL_WIDTH, 'center')
            love.graphics.printf('Press ENTER or RETURN to restart', 0, 42, VIRTUAL_WIDTH, 'center')
        end
    end

    -- Score
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)

    push:apply('end')
end

function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 40, 20)
    love.graphics.setColor(1, 1, 1, 1)
end

function isGamerOver()
    if player1Score == 9 or player2Score == 9 then
        return true
    else
        return false
    end
end