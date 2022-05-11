NMG = NMG or {}
NMG.AttachmentShop = NMG.AttachmentShop or {}

if SERVER then
    util.AddNetworkString("NGM.AttachmentShop.BuyAttachments")

    include("sv_att-shop.lua")
    AddCSLuaFile("attachment_shop/vgui/attachment_shop-panel.lua")

    if (VoidLib) then
        include("attachment_shop/sv_database.lua")
        print("[NMG] Attachment Shop Loaded")
    else
        hook.Add("VoidLib.Loaded", "NMG.AttachmentShop.Init.WaitForVoidLib", function ()
            include("attachment_shop/sv_database.lua")
            print("[NMG] Attachment Shop Loaded")
        end)
    end
end

if CLIENT then
    include("attachment_shop/vgui/attachment_shop-panel.lua")
end