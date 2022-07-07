KXX = KXX or {}
KXX.AttachmentShop = KXX.AttachmentShop or {}

if SERVER then
    if (VoidLib) then
        include("attachment_shop/sv_database.lua")
        print("[KXX] Attachment Shop Loaded")
    else
        hook.Add("VoidLib.Loaded", "KXX.AttachmentShop.Init.WaitForVoidLib", function ()
            include("attachment_shop/sv_database.lua")
            print("[KXX] Attachment Shop Loaded")
        end)
    end

    util.AddNetworkString("KXX.AttachmentShop.BuyAttachments")
    util.AddNetworkString("KXX.AttachmentShop.DeletePreset")
    util.AddNetworkString("KXX.AttachmentShop.SavePreset")
    util.AddNetworkString("KXX.AttachmentShop.SelectPreset")
    util.AddNetworkString("KXX.AttachmentShop.SendPresetToClient")

    include("attachment_shop/sv_att-shop.lua")
    AddCSLuaFile("attachment_shop/vgui/cl_attachmentshop.lua")
    AddCSLuaFile("attachment_shop/vgui/cl_itemdetails.lua")
    AddCSLuaFile("attachment_shop/sh_att-shop.lua")
    AddCSLuaFile("attachment_shop/cl_att-shop.lua")
end

if CLIENT then
    include("attachment_shop/vgui/cl_attachmentshop.lua")
    include("attachment_shop/vgui/cl_itemdetails.lua")
    include("attachment_shop/cl_att-shop.lua")
end

include("attachment_shop/sh_att-shop.lua")