local PANEL = {}

function PANEL:SetAttachment(bool)
    self.attachment = bool or false
end

function PANEL:SetItem(classname)
    self.item = NMG.AttachmentShop.ItemData[classname]
end

function PANEL:ShopDetail(bool)
    self.shopdetail = bool or false
end

function PANEL:ShoppingCartDetail(bool)
    self.shoppingcartdetail = bool or false
end


function PANEL:Init()
    self:SetText("")
    self:SSetSize(150, 70)
end

function PANEL:OnCursorEntered()
   if self.shopdetail or self.shoppingcartdetail then

        if not IsValid(self.hoverdetail) then
            self.hoverdetail = vgui.Create("Panel")
        end

        self.hoverdetail:SetDrawOnTop(true)
        self.hoverdetail:SetPos(input.GetCursorPos())

        if self.shopdetail then
            self.hoverdetail:SSetSize(300, 75)
        else
            self.hoverdetail:SSetSize(320, 75)
        end

        self.hoverdetail:Show()
        self.hoverdetail.Paint = function(s, w, h)
            if not IsValid(self) then return end
            self.hoverdetail:SetPos(input.GetCursorPos())
            draw.RoundedBox(12, 0, 0, w, h, VoidUI.Colors.Primary)

            if self.shopdetail then
                draw.SimpleText("Zum Warenkorb hinzufügen", "VoidUI.R26", w / 2, h / 2, VoidUI.Colors.Green, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                surface.SetDrawColor(VoidUI.Colors.Green)
            else
                draw.SimpleText("Aus dem Warenkorb entfernen", "VoidUI.R26", w / 2, h / 2, VoidUI.Colors.Red, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                surface.SetDrawColor(VoidUI.Colors.Red)
            end
            surface.DrawOutlinedRect(0, 0, w, h, 3)
        end
    end
end

function PANEL:OnCursorExited()
    if  self.shopdetail or self.shoppingcartdetail then
        if not IsValid(self.hoverdetail) then return end

        self.hoverdetail:Remove()
    end
end

function PANEL:DoClick()
    if IsValid(self.hoverdetail) then
        self.hoverdetail:Remove()
    end
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
        surface.SetTexture(surface.GetTextureID(self.item.icon))
    else
        surface.SetMaterial(Material(self.item.icon))
    end
    surface.DrawTexturedRect(7.5, 10, 50, 50)

    draw.RoundedBox(0, 65, 5, 1, h - 10, VoidUI.Colors.White)

    // draws the text
    if self.shoppingcartdetail then
        draw.SimpleText(self.item.printName, "VoidUI.R26", self:GetWide() / 2 - 20, 20, VoidUI.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(self.item.description, "VoidUI.R18", self:GetWide() / 2 - 20, 40, VoidUI.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
    else
        draw.SimpleText(self.item.printName, "VoidUI.R26", self:GetWide() / 2 - 70, 20, VoidUI.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(self.item.description, "VoidUI.R18", self:GetWide() / 2 - 70, 40, VoidUI.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
    end
end

vgui.Register("NMG.AttachmentShop.ItemDetails", PANEL, "DButton")

