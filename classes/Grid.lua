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
	function switch(i1,j1,i2,j2)
		local tween1 = GTween.new(self.mt[i1][j1], 0.3, {x = self.mt[i2][j2]:getX(), y = self.mt[i2][j2]:getY()})
		local tween2 = GTween.new(self.mt[i2][j2], 0.3, {x = self.mt[i1][j1]:getX(), y = self.mt[i1][j1]:getY()}, {dispatchEvents = true})
		if not self:checkMatch(i1,j1,self.mt[i2][j2].color) and not self:checkMatch(i2,j2,self.mt[i1][j1].color) then
			tween2:addEventListener("complete", function()
				GTween.new(self.mt[i1][j1], 0.3, {x = self.mt[i2][j2]:getX(), y = self.mt[i2][j2]:getY()})
				GTween.new(self.mt[i2][j2], 0.3, {x = self.mt[i1][j1]:getX(), y = self.mt[i1][j1]:getY()})
			end)
		end
	end
	-- mulai isi matriks dengan match
    for i=1,self.row do
		for j=1,self.column do
			if matrix[i][j] ~= 0 then
				local color = math.random(1,variation)
				while self:checkMatch(i,j,color) do
					color = math.random(1,variation)
				end
				self.mt[i][j] = Match.new(color,i,j)
				self.mt[i][j]:addEventListener("kanan", function()
					print("match("..i..","..j..") kanan")
					switch(i,j,i+1,j)
				end)
				self.mt[i][j]:addEventListener("atas", function()
					print("match("..i..","..j..") atas")
					switch(i,j,i,j-1)
				end)
				self.mt[i][j]:addEventListener("kiri", function()
					print("match("..i..","..j..") kiri")
					switch(i,j,i-1,j)
				end)
				self.mt[i][j]:addEventListener("bawah", function()
					print("match("..i..","..j..") bawah")
					switch(i,j,i,j+1)
				end)
				self:addChild(self.mt[i][j])
			end
		end
    end
end

function Grid:checkMatch(i,j,color)
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
	if i<self.row-1 then
		if (self.mt[i+1][j].color == color) and (self.mt[i+2][j].color == color) then
			return true
		end
	end
	if j<self.column-1 then
		if (self.mt[i][j+1].color == color) and (self.mt[i][j+2].color == color) then
			return true
		end
	end
	return false
end