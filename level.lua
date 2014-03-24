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

offset_x = 15
offset_y = 15
max_x = 465
max_y = 465
	
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
	self:addChild(grid)
end

--removing event
function level:onEnterFrame() 
	
end

--removing event on exiting scene
function level:onExitBegin()
  self:removeEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end