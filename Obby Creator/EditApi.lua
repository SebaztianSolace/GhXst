-- === EditApi Module ===
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EditApi = {}

-- Set editing mode
function EditApi.SetEditing(part, editing)
    local args = { {part}, editing or false }
    ReplicatedStorage:WaitForChild("Events"):WaitForChild("SetEditing"):FireServer(unpack(args))
end

-- Change current selection
function EditApi.ChangeCurrentSelection(part, mode)
    local args = { mode or "Add", {part} }
    ReplicatedStorage:WaitForChild("Events"):WaitForChild("ChangeCurrentSelection"):FireServer(unpack(args))
end

-- Move object
function EditApi.MoveObject(part, cframe, size)
    local args = { { {part, cframe or part.CFrame, size or Vector3.new(1,1,1)} } }
    return ReplicatedStorage:WaitForChild("Events"):WaitForChild("MoveObject"):InvokeServer(unpack(args))
end

-- Add a new part/object
function EditApi.AddObject(objectName, cframe)
    local args = { objectName, cframe }
    local newPart = ReplicatedStorage:WaitForChild("Events"):WaitForChild("AddObject"):InvokeServer(unpack(args))
    return newPart -- returns the created part
end

-- Delete a part/object
function EditApi.DeleteObject(part)
    local args = { {part} }
    ReplicatedStorage:WaitForChild("Events"):WaitForChild("DeleteObject"):InvokeServer(unpack(args))
end

return EditApi
