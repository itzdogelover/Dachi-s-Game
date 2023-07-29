Ball = Class{}

function Ball:init(x, y)
    self.x = x
    self.y = y

    self.width = 6
    self.height = 6

    self.dx = math.random(-10, 10)
end

function Ball:update(dt)
    self.y = self.y + (BALL_SPEED + score) * dt
    self.x = self.x + self.dx * dt

    if self.x <= 0 or self.x + self.width >= VIRTUAL_WIDTH then
        self.dx = -self.dx
    end
end

function Ball:collides(target)
    if self.y + self.height < target.y or self.y > target.y + target.height then
        return false
    end

    if self.x + self.width < target.x or self.x > target.x + target.width then
        return false
    end

    return true
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end