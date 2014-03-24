--[[
*************************************************************
 * This script is developed by Arturs Sosins aka ar2rsawseen, http://appcodingeasy.com
 * Feel free to distribute and modify code, but keep reference to its creator
 *
 * Gideros Game Template for developing games. Includes: 
 * Start scene, pack select, level select, settings, score system and much more
 *
 * For more information, examples and online documentation visit: 
 * http://appcodingeasy.com/Gideros-Mobile/Gideros-Mobile-Game-Template
**************************************************************
]]--

level = gideros.class(Sprite)

function level:init()
	local matrix = {}
    for i=1,15 do
		matrix[i] = {}
		for j=1,15 do
			matrix[i][j] = 1
		end
    end
	local grid = Grid.new(matrix,5)
	offset_x = 15
	offset_y = 15
	max_x = 465
	max_y = 465
	for i=1,grid.row do
		for j=1,grid.column do
			local m = Match.new(grid.mt[i][j],i,j)
			m:addEventListener("kiri", function()
				print("match("..i..","..j..") kiri")
			end)
			m:addEventListener("kanan", function()
				print("match("..i..","..j..") kanan")
			end)
			m:addEventListener("atas", function()
				print("match("..i..","..j..") atas")
			end)
			m:addEventListener("bawah", function()
				print("match("..i..","..j..") bawah")
			end)
			self:addChild(m)
		end
    end
end

--removing event
function level:onEnterFrame() 
	
end

--removing event on exiting scene
function level:onExitBegin()
  self:removeEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end