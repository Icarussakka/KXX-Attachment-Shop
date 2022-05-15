AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

util.AddNetworkString("NMG.AttachmentShop.SendShop")

function ENT:Initialize()
    self:SetModel(NMG.AttachmentShop.EntityModel)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
end

local cd = false

function ENT:Use(ply, activator)
    if not IsFirstTimePredicted() then return end
    if cd then return end
    cd = true

    net.Start("NMG.AttachmentShop.SendShop")
    net.Send(ply)
    timer.Simple(0.1, function() cd = false end)
end
