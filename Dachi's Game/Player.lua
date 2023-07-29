Player = Class{}

function Player:init(x, y)
	self.x = x
	self.y = y
	
	self.width = 36
	self.height = 6

	self.dy = 0
end

function Player:update(dt)
	if (self.x > 0) and (self.x + self.width < VIRTUAL_WIDTH) then
		if love.keyboard.isDown('left') then
			self.x = self.x - PLAYER_SPEED * dt
		elseif love.keyboard.isDown('right') then
			self.x = self.x + PLAYER_SPEED * dt
		end
	end

	if self.x <= 0 then
		if love.keyboard.isDown('right') then
			self.x = self.x + PLAYER_SPEED * dt
		end
	end

	if self.x + self.width >= VIRTUAL_WIDTH then
		if love.keyboard.isDown('left') then
			self.x = self.x - PLAYER_SPEED * dt
		end
	end
end

function Player:render()
	love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
