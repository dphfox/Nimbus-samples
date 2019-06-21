local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui

--dealing with Roblox stuff
game:GetService("StarterGui"):SetCore("TopbarEnabled", false)
game:GetService("UserInputService").ModalEnabled = true

local Nimbus = require(script.Parent:WaitForChild "Nimbus")
local State = Nimbus.State
local Widgets = Nimbus.Widgets
local ScreenGui = Widgets.Roblox.ScreenGui
local Frame = Widgets.Roblox.Frame

local Topbar = require(script.Topbar)
local AddTaskBox = require(script.AddTaskBox)
local TaskView = require(script.TaskView)

local function build()
	local scrollAmt, setScrollAmt = State(0)
	local filterBy, setFilterBy = State("All")
	local tasks, setTasks = State({
		{text = "Eat lunch", completed = true},
		{text = "Finish event handlers", completed = true},
		{text = "Take over the world", completed = false}
	})
	
	return ScreenGui "TodoApp" {
		ZIndexBehavior = "Sibling",
		IgnoreGuiInset = true,
		
		Frame "Main" {
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundColor3 = Color3.fromRGB(242, 242, 242),
			
			Topbar(scrollAmt, filterBy, setFilterBy),
			TaskView(filterBy, tasks, setTasks, setScrollAmt),
			AddTaskBox(setTasks)
		}
	}
end

Nimbus.Mount(build, PlayerGui)