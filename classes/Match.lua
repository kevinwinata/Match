Match = gideros.class(Sprite)

function Match:init(color, i, j)
	local disp
	if color == 0 then
		disp = Bitmap.new(imgres:getTextureRegion("none.png"))
		self.color = 0
	elseif color == 1 then
		disp = Bitmap.new(imgres:getTextureRegion("red.png"))
		self.color = 1
	elseif color == 2 then
		disp = Bitmap.new(imgres:getTextureRegion("green.png"))
		self.color = 2
	elseif color == 3 then
		disp = Bitmap.new(imgres:getTextureRegion("blue.png"))
		self.color = 3
	elseif color == 4 then
		disp = Bitmap.new(imgres:getTextureRegion("yellow.png"))
		self.color = 4
	else
		disp = Bitmap.new(imgres:getTextureRegion("purple.png"))
		self.color = 5
	end
	self:addChild(disp)
	self:setPosition((i-1)*30+offset_x,(j-1)*30+offset_y)
	
	self:addEventListener(Event.MOUSE_DOWN, self.onMouseDown, self)
	self:addEventListener(Event.MOUSE_MOVE, self.onMouseMove, self)
	self:addEventListener(Event.MOUSE_UP, self.onMouseUp, self)
end


function Match:onMouseDown(event)
	if self:hitTestPoint(event.x, event.y) then
		self.focus = true
		event:stopPropagation()
	end
end

function Match:onMouseMove(event)
	if self.focus and event.x > offset_x and event.x < max_x  and event.y > offset_y and event.y < max_y then
		if math.abs(self:getX()-event.x) >= math.abs(self:getY()-event.y) then
			if event.x > self:getX()+(self:getWidth()*1.2) then
				if not self.moved then
					self:dispatchEvent(Event.new("kanan"))
					self.moved = true
				end
			elseif event.x < self:getX()-(self:getWidth()*0.2) then
				if not self.moved then
					self:dispatchEvent(Event.new("kiri"))
					self.moved = true
				end
			end
		else
			if event.y > self:getY()+(self:getHeight()*1.2) then
				if not self.moved then
					self:dispatchEvent(Event.new("bawah"))
					self.moved = true
				end
			elseif event.y < self:getY()-(self:getHeight()*0.2) then
				if not self.moved then
					self:dispatchEvent(Event.new("atas"))
					self.moved = true
				end
			end
		end
		event:stopPropagation()
	end
end

function Match:onMouseUp(event)
	if self.focus then
		self.focus = false
		self.moved = false
		event:stopPropagation()
	end
end
