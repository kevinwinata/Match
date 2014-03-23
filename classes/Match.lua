Match = gideros.class(Sprite)

function Match:init(color, posx, posy)
	local disp
	if color == 1 then
		disp = Bitmap.new(imgres:getTextureRegion("red.png"))
	elseif color == 2 then
		disp = Bitmap.new(imgres:getTextureRegion("green.png"))
	elseif color == 3 then
		disp = Bitmap.new(imgres:getTextureRegion("blue.png"))
	elseif color == 4 then
		disp = Bitmap.new(imgres:getTextureRegion("yellow.png"))
	else
		disp = Bitmap.new(imgres:getTextureRegion("purple.png"))
	end
	self:addChild(disp)
	self:setPosition(posx, posy)
end