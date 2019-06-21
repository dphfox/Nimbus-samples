local Nimbus = require(script.Parent.Parent.Nimbus)
local Widgets = Nimbus.Widgets
local Frame = Widgets.Roblox.Frame
local TextLabel = Widgets.Roblox.TextLabel
local TextButton = Widgets.Roblox.TextButton
local UIListLayout = Widgets.Roblox.UIListLayout
local ForEach = Widgets.Logical.ForEach

local function Topbar(scrollAmt, filterBy, setFilterBy)
	
	return Frame "Topbar" {
		BackgroundColor3 = Color3.new(0, 2/3, 0.5),
		BorderSizePixel = 0,
		ZIndex = 10,
		
		Size = scrollAmt:use(function(scrollAmt)
			return UDim2.new(1, 0, 0, math.clamp(150-scrollAmt, 40, math.huge))
		end),
		
		TextLabel "Title" {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -20, 0, 30),
			Font = "SourceSansBold",
			Text = "To-Do",
			TextSize = 20,
			TextColor3 = Color3.new(1, 1, 1),
			TextXAlignment = "Left",
			
			Position = scrollAmt:use(function(scrollAmt)
				local minPosition = UDim2.new(0, 10 + 36*2, 0, 5)
				local maxPosition = UDim2.new(0, 10, 1, -35)
				local factor = math.clamp(scrollAmt/150, 0, 1)
				factor = 3*factor^2 - 2*factor^3
				return maxPosition:Lerp(minPosition, factor)
			end)
		},
		
		Frame "Filters" {
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, -5, 0, 5),
			Size = UDim2.new(0, 227, 0, 30),
			BackgroundTransparency = 1,
			
			UIListLayout {
				Padding = UDim.new(0, 1),
				FillDirection = "Horizontal",
				SortOrder = "LayoutOrder"
			},
			
			ForEach {"Incomplete", "Completed", "All"} (function(filterKind, layoutOrder)
				return TextButton {
					Size = UDim2.new(0, 75, 1, 0),
					BorderColor3 = Color3.new(1, 1, 1),
					Name = filterKind,
					LayoutOrder = layoutOrder,
					Font = "SourceSans",
					Text = filterKind,
					TextSize = 14,
					
					BackgroundColor3 = filterKind:compose(filterBy, function(filterKind, filterBy)
						if filterBy == filterKind then return Color3.new(1, 1, 1) else return Color3.new(0, 2/3, 0.5) end
					end),
					TextColor3 = filterKind:compose(filterBy, function(filterKind, filterBy)
						if filterBy ~= filterKind then return Color3.new(1, 1, 1) else return Color3.new(0, 2/3, 0.5) end
					end),
					
					[TextButton.On.Activated] = filterKind:use(function(filterKind)
						return function()
							setFilterBy(filterKind)
						end
					end)
				}
			end)
		}
	}
	
end

return Topbar