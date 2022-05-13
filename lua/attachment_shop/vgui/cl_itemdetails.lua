local PANEL = {}

function PANEL:SetItem(classname)
    self.item = classname
end

function PANEL:Init()
    self:SetText("")
    self:SSetSize(150, 50)
end

function PANEL:Paint(w, h)
    if self:IsHovered() then
        draw.RoundedBox(3, 0, 0, w, h, VoidUI.Colors.BackgroundTransparent)
    else
        draw.RoundedBox(3, 0, 0, w, h, VoidUI.Colors.DarkGrayTransparent)
    end
end

vgui.Register("NMG.AttachmentShop.ItemDetails", PANEL, "DButton")