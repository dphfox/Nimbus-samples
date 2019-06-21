local Nimbus = require(script.Parent.Parent.Nimbus)
local Widgets = Nimbus.Widgets
local ScrollingFrame = Widgets.Roblox.ScrollingFrame
local UIPadding = Widgets.Roblox.UIPadding
local UIListLayout = Widgets.Roblox.UIListLayout
local ForEach = Widgets.Logical.ForEach
local If = Widgets.Logical.If

local Task = require(script.Parent.Task)

local function TaskView(filterBy, tasks, setTasks, setScrollAmt)
	
	local function shouldShowTask(task)
		return filterBy:compose(task, function(filterBy, task)
			if filterBy == "Incomplete" then
				return not task.completed
			elseif filterBy == "Completed" then
				return task.completed
			else
				return true
			end
		end)
	end
	
	return ScrollingFrame "TaskView" {
		Position = UDim2.new(0, 0, 0, 0),
		Size = UDim2.new(1, 0, 1, -40),
		
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		
		ScrollBarImageColor3 = Color3.new(0, 0, 0),
		ScrollingDirection = "Y",
		ScrollBarThickness = 4,
		VerticalScrollBarInset = "ScrollBar",
		
		CanvasSize = tasks:compose(filterBy, function(tasks, filterBy)
			local taskHeight = 0
			for i=1, #tasks do
				local task = tasks[i]
				local shouldShow = true
				
				if filterBy == "Incomplete" then
					shouldShow = not task.completed
				elseif filterBy == "Completed" then
					shouldShow = task.completed
				end
				
				if shouldShow then
					taskHeight = taskHeight + 41
				end
			end
			return UDim2.new(0, 0, 0, 150 + taskHeight + 150)
		end),
		
		[ScrollingFrame.OnChange.CanvasPosition] = function(self, newPos)
			setScrollAmt(newPos.Y)
		end,
		
		UIListLayout {
			Padding = UDim.new(0, 1),
			SortOrder = "LayoutOrder"
		},
		
		UIPadding {
			PaddingTop = UDim.new(0, 150)
		},
		
		ForEach(tasks) (function(task, index)
			return If(shouldShowTask(task)) {
				Task(task, index, setTasks)
			}
		end)
	}
end

return TaskView