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

function EditApi.AddObject(objectName, cframe)
    local args = { objectName, cframe }
    local newPart = ReplicatedStorage.Events.AddObject:InvokeServer(unpack(args))
    return newPart -- returns created part
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
