local PANEL = {}

function PANEL:SetItem(classname)
    self.item = NMG.AttachmentShop.ItemData[classname]
end

function PANEL:SetAttachment(bool)
    self.attachment = bool or false
end

function PANEL:Init()
    self:SetText("")
    self:SSetSize(150, 70)
end

function PANEL:Paint(w, h)
    if self:IsHovered() then
        draw.RoundedBox(3, 0, 0, w, h, VoidUI.Colors.BackgroundTransparent)
    else
        draw.RoundedBox(3, 0, 0, w, h, VoidUI.Colors.DarkGrayTransparent)
    end

    //draws the icon
    surface.SetDrawColor(color_white)

    if self.attachment then
        surface.SetTexture(self.item.icon or NMG.AttachmentShop.FallbackIcons.textureFallback)
    else
        surface.SetMaterial(self.item.icon or NMG.AttachmentShop.FallbackIcons.materialFallback)
    end

    surface.DrawTexturedRect(15, 15, 40, 40)

    // draws the text
    draw.SimpleText(self.item.printName, "VoidUI.R26", self:GetWide() / 2 , 20, VoidUI.Colors.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    draw.SimpleText(self.item.description, "VoidUI.R18", self:GetWide() / 2 - 70 , 40, VoidUI.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
end

vgui.Register("NMG.AttachmentShop.ItemDetails", PANEL, "DButton")