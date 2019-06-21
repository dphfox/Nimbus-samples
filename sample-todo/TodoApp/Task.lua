local Nimbus = require(script.Parent.Parent.Nimbus)
local Widgets = Nimbus.Widgets
local Frame = Widgets.Roblox.Frame
local TextLabel = Widgets.Roblox.TextLabel
local TextButton = Widgets.Roblox.TextButton

local function Task(task, index, setTasks)
	
	return Frame "Task" {
		Size = UDim2.new(1, 0, 0, 40),
		BackgroundColor3 = Color3.new(1, 1, 1),
		BorderColor3 = Color3.fromRGB(220, 220, 220),
		LayoutOrder = index,
		
		TextLabel "TaskText" {
			Position = UDim2.new(0, 10, 0, 5),
			Size = UDim2.new(1, -20, 1, -10),
			BackgroundTransparency = 1,
			
			Font = "SourceSans",
			TextSize = 14,
			TextWrapped = true,
			TextXAlignment = "Left",
			
			Text = task:use(function(task)
				return task.text
			end)
		},
		
		TextButton "Completed" {
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, -10, 0, 10),
			Size = UDim2.new(0, 20, 0, 20),
			BorderSizePixel = 0,
			Text = "",
			
			BackgroundColor3 = task:use(function(task)
				return task.completed and Color3.new(0, 2/3, 0.5) or Color3.fromRGB(220, 220, 220)
			end),
			
			[TextButton.On.Activated] = index:compose(task, function(index, task)
				return function()
					setTasks(function(tasks)
						tasks[index].completed = not task.completed
						return tasks
					end)
				end
			end)
		}
	}
	
end

return Task