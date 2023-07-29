Class = require 'class'
push = require 'push'

require 'Player'
require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

ball = nil
score = 0

PLAYER_SPEED = 250
BALL_SPEED = 150

gameState = 'start'

function love.load()

    love.window.setTitle("Dachi's Game")

    love.graphics.setDefaultFilter('nearest', 'nearest')
    smallFont = love.graphics.newFont('font.ttf', 8)
    scoreFont = love.graphics.newFont('font.ttf', 16)

    love.graphics.setFont(smallFont)

    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = false,
		vsync = true
	})

  player = Player(VIRTUAL_WIDTH/2 - 18, 200)

  catchSound = love.audio.newSource('catch.wav', 'static')
  gameOverSound = love.audio.newSource('game_over.wav', 'static')

end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  elseif key == 'space' and gameState == 'start' then
    gameState = 'play'
  end
end

function love.update(dt)
  if gameState == 'start' then
    player.x = VIRTUAL_WIDTH/2 - player.width/2
    player.y = 200
  end
  if gameState == 'play' then
      player:update(dt)

      if ball == nil then
          ball = Ball(math.random(0, VIRTUAL_WIDTH - 4), 0)
      else
          ball:update(dt)

          if ball:collides(player) then
              score = score + 1
              ball = nil
              catchSound:play()
          end

          if ball and ball.y >= VIRTUAL_HEIGHT then
              gameState = 'start'
              score = 0
              ball = nil
              gameOverSound:play()
          end
      end
  end
end

function love.draw()
  push:apply('start')

  love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

  if gameState == 'start' then
      love.graphics.setFont(smallFont)
      love.graphics.printf('Press Space to Start', 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')
  elseif gameState == 'play' then
      player:render()
      if ball then
          ball:render()
      end
      love.graphics.setFont(scoreFont)
      love.graphics.print('Score: ' .. score, 8, 8)
  end

  push:apply('end')
end