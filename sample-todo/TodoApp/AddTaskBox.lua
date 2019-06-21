local Nimbus = require(script.Parent.Parent.Nimbus)
local Widgets = Nimbus.Widgets
local Frame = Widgets.Roblox.Frame
local TextBox = Widgets.Roblox.TextBox

local function AddTaskBox(setTasks)
	
	return Frame "AddTask" {
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.new(0, 0, 1, 0),
		Size = UDim2.new(1, 0, 0, 40),
		BackgroundColor3 = Color3.new(1, 1, 1),
		BorderColor3 = Color3.fromRGB(220, 220, 220),
		ZIndex = 20,
		
		TextBox {
			Position = UDim2.new(0, 10, 0, 0),
			Size = UDim2.new(1, -20, 1, 0),
			
			BackgroundTransparency = 1,
			ClearTextOnFocus = false,
			
			Font = "SourceSans",
			PlaceholderText = "Add a task...",
			Text = "",
			TextSize = 14,
			
			TextXAlignment = "Left",
			TextWrapped = true,
			
			[TextBox.On.FocusLost] = function(self, enterPressed)
				if not enterPressed then return end
				
				local taskText = self:GetComputed("Text")
				if taskText == "" then return end
				
				self:SetProperty("Text", "")
				
				local newTask = {text = taskText, completed = false}
				setTasks(function(tasks)
					tasks[#tasks + 1] = newTask
					return tasks
				end)
			end
		}
	}
	
end

return AddTaskBox