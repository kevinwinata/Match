Grid = gideros.class(Sprite)

function Grid:init(matrix, variation)
	self.row = table.getn(matrix)
	self.column = table.getn(matrix[1])
	self.variation = variation
	math.randomseed( os.time() )
	self.mt = {}
	-- inisialisasi matriks
    for i=1,self.row do
		self.mt[i] = {}
		for j=1,self.column do
			self.mt[i][j] = Match.new(0,i,j)
		end
    end
	-- fungsi tukar match
	function switch(pos)	
		local i1 = pos[1]
		local j1 = pos[2]
		local i2 = pos[3]
		local j2 = pos[4]
		local temp = self.mt[i1][j1]
		local tween1 = GTween.new(self.mt[i1][j1], 0.3, {x = self.mt[i2][j2]:getX(), y = self.mt[i2][j2]:getY()})
		self.mt[i1][j1] = self.mt[i2][j2]
		local tween2 = GTween.new(self.mt[i2][j2], 0.3, {x = temp:getX(), y = temp:getY()}, {dispatchEvents = true})
		self.mt[i2][j2] = temp
		local match1,a,b = self:checkMatch(i1,j1,self.mt[i1][j1].color)
		local match2,a,b = self:checkMatch(i2,j2,self.mt[i2][j2].color)
		if match1 or match2 then
			if match1=="h" then
				print(match1..a..b.."h")
			elseif match1=="v" then
				print(match1..a..b.."v")
			end
			if match2=="h" then
				print(match2..a..b.."h")
			elseif match2=="v" then
				print(match2..a..b.."v")
			end
		else
			tween2:addEventListener("complete", function()
				GTween.new(self.mt[i1][j1], 0.3, {x = self.mt[i2][j2]:getX(), y = self.mt[i2][j2]:getY()})
				GTween.new(self.mt[i2][j2], 0.3, {x = self.mt[i1][j1]:getX(), y = self.mt[i1][j1]:getY()})
				local temp = self.mt[i1][j1]
				self.mt[i1][j1] = self.mt[i2][j2]
				self.mt[i2][j2] = temp
			end)
		end
	end
	-- mulai isi matriks dengan match
    for i=1,self.row do
		for j=1,self.column do
			if matrix[i][j] ~= 0 then
				local color = math.random(1,variation)
				while self:checkMatchInit(i,j,color) do
					color = math.random(1,variation)
				end
				self.mt[i][j] = Match.new(color,i,j)
				self.mt[i][j]:addEventListener("kanan", switch, {i,j,i+1,j})
				self.mt[i][j]:addEventListener("atas", switch, {i,j,i,j-1})
				self.mt[i][j]:addEventListener("kiri", switch, {i,j,i-1,j})
				self.mt[i][j]:addEventListener("bawah", switch, {i,j,i,j+1})
				self:addChild(self.mt[i][j])
			end
		end
    end
end

function Grid:checkMatchInit(i,j,color)
	if i>2 then
		if (self.mt[i-1][j].color == color) and (self.mt[i-2][j].color == color) then
			return true
		end
	end
	if j>2 then
		if (self.mt[i][j-1].color == color) and (self.mt[i][j-2].color == color) then
			return true
		end
	end
	return false
end

function Grid:checkMatch(i,j,color)
	local left = 0
	local right = 0
	local top = 0
	local down = 0
	
	local temp = color
	local n = 1
	while temp == color and i-n >= 1 do
		temp = self.mt[i-n][j].color
		if temp == color then left = left + 1 end
		n = n + 1
	end
	temp = color
	n = 1
	while temp == color and i+n <= self.row do
		temp = self.mt[i+n][j].color
		if temp == color then right = right + 1 end
		n = n + 1
	end
	if left+right >= 2 then
		return "h",left,right
	end
	
	temp = color
	n = 1
	while temp == color and j-n >= 1 do
		temp = self.mt[i][j-n].color
		if temp == color then top = top + 1 end
		n = n + 1
	end
	temp = color
	n = 1
	while temp == color and j+n <= self.column do
		temp = self.mt[i][j+n].color
		if temp == color then down = down + 1 end
		n = n + 1
	end
	if top+down >= 2 then
		return "v",top,down
	end
	
	return false
end