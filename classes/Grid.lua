Grid = Core.class()

function Grid:init(matrix, variation)
	self.row = table.getn(matrix)
	self.column = table.getn(matrix[1])
	self.variation = variation
	math.randomseed( os.time() )
	self.mt = {}
    for i=1,self.row do
		self.mt[i] = {}
		for j=1,self.column do
			self.mt[i][j] = 0
		end
    end
    for i=1,self.row do
		for j=1,self.column do
			if matrix[i][j] ~= 0 then
				self.mt[i][j] = math.random(1,variation)
				while self:checkMatch(i,j) do
					self.mt[i][j] = math.random(1,variation)
				end
			end
		end
    end
end

function Grid:checkMatch(i,j)
	local color = self.mt[i][j]
	if i>2 then
		if (self.mt[i-1][j] == color) and (self.mt[i-2][j] == color) then
			return true
		end
	end
	if j>2 then
		if (self.mt[i][j-1] == color) and (self.mt[i][j-2] == color) then
			return true
		end
	end
	if i<self.row-1 then
		if (self.mt[i+1][j] == color) and (self.mt[i+2][j] == color) then
			return true
		end
	end
	if j<self.column-1 then
		if (self.mt[i][j+1] == color) and (self.mt[i][j+2] == color) then
			return true
		end
	end
end