-- === EditApi Module ===
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EditApi = {}

-- 🔹 Editing + Selection
function EditApi.SetEditing(part, editing)
	local args = { {part}, editing or false }
	ReplicatedStorage.Events.SetEditing:FireServer(unpack(args))
end

function EditApi.ChangeCurrentSelection(part, mode)
	local args = { mode or "Add", {part} }
	ReplicatedStorage.Events.ChangeCurrentSelection:FireServer(unpack(args))
end

-- 🔹 Object Movement + Creation
function EditApi.MoveObject(part, cframe, size)
	local args = { { {part, cframe or part.CFrame, size or Vector3.new(1,1,1)} } }
	return ReplicatedStorage.Events.MoveObject:InvokeServer(unpack(args))
end

function EditApi.AddObject(objectName, targetCFrame)
	local args = { objectName, targetCFrame }
	local success = ReplicatedStorage.Events.AddObject:InvokeServer(unpack(args))
	if not success then
		warn("Failed to request object creation")
		return nil
	end

	-- Wait for the part to appear in Workspace
	local Players = game:GetService("Players")
	local playerName = Players.LocalPlayer.Name
	local partsFolder = workspace:WaitForChild("Obbies"):WaitForChild(playerName):WaitForChild("Items"):WaitForChild("Parts")

	local newPart = partsFolder.ChildAdded:Wait()

	-- Check CFrame matches (optional fuzzy check for safety)
	if (newPart.CFrame.Position - targetCFrame.Position).Magnitude <= 0.1 then
		return newPart
	else
		-- If it doesn't match, you could loop until you find the correct one
		for _, part in ipairs(partsFolder:GetChildren()) do
			if (part.CFrame.Position - targetCFrame.Position).Magnitude <= 0.1 then
				return part
			end
		end
	end

	-- fallback
	return newPart
end


function EditApi.DeleteObject(part)
	local args = { {part} }
	ReplicatedStorage.Events.DeleteObject:InvokeServer(unpack(args))
end

-- 🔹 Painting / Property Changing
function EditApi.SetColor(part, color)
	local args = { {part}, "Color", color }
	ReplicatedStorage.Events.PaintObject:InvokeServer(unpack(args))
end

function EditApi.SetMaterial(part, material)
	local args = { {part}, "Material", material }
	ReplicatedStorage.Events.PaintObject:InvokeServer(unpack(args))
end

function EditApi.SetTransparency(part, transparency)
	local args = { {part}, "Transparency", transparency }
	ReplicatedStorage.Events.PaintObject:InvokeServer(unpack(args))
end

function EditApi.SetReflectance(part, reflectance)
	local args = { {part}, "Reflectance", reflectance }
	ReplicatedStorage.Events.PaintObject:InvokeServer(unpack(args))
end

function EditApi.SetCanCollide(part, canCollide)
	local args = { {part}, "CanCollide", canCollide }
	ReplicatedStorage.Events.PaintObject:InvokeServer(unpack(args))
end

return EditApi
