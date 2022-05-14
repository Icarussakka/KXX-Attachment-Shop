local PANEL = {}
local ShoppingCart = ShoppingCart or {}

function PANEL:Init()
    self:SetTitle("Aufsatz Händler")
    self:SSetSize(1300, 850)
    self:Center()
    self:MakePopup()
end

function PANEL:GetPresets()
    CreateConVar("NMG.AttachmentShop.Preset", 0, FCVAR_NONE)

    self.presetPanel = self:Add("VoidUI.BackgroundPanel")
    self.presetPanel:Dock(LEFT)
    self.presetPanel:SSetSize(250, 0)
    self.presetPanel:DockMargin(15,15,15,15)
    self.presetPanel:SetTitle("Presets")

    local scrollPanel = self.presetPanel:Add("VoidUI.ScrollPanel")
    scrollPanel:Dock(FILL)
    scrollPanel:DockMargin(0, 40, 0, 0)

    for i = 1, 8 do // TODO : add cfg var
        self.presets = scrollPanel:Add("VoidUI.Button")
        self.presets:Dock(TOP)
        self.presets:DockMargin(15,0,10,15)
        self.presets:SSetSize(250, 35)
        self.presets:SetText("Preset " .. i)
        self.presets:SetColor(VoidUI.Colors.White)
        self.presets.DoClick = function()
            RunConsoleCommand("NMG.AttachmentShop.Preset", i)
        end
    end

    for _, buttonData in ipairs(NMG.AttachmentShop.PresetButton) do
        self.presetButton = self.presetPanel:Add("VoidUI.Button")
        self.presetButton:Dock(BOTTOM)
        self.presetButton:DockMargin(15,15,10,10)
        self.presetButton:SSetSize(250, 35)
        self.presetButton:SetColor(buttonData.color)
        self.presetButton:SetText(buttonData.name)
        self.presetButton.DoClick = buttonData.buttonFunc
    end
end

function PANEL:GetAttachments()
    local shopPanel = self:Add("VoidUI.BackgroundPanel")
    shopPanel:Dock(LEFT)
    shopPanel:SSetSize(740, 0)
    shopPanel:DockMargin(0,15,0,15)
    shopPanel.Paint = function (s, w, h)
        // draws the white lines and the text
        draw.RoundedBox(12, 0, 0, w, h, VoidUI.Colors.Primary)
        draw.RoundedBox(0, w / 2, 75, 1, h - 95 , VoidUI.Colors.White)
        draw.RoundedBox(0, 20, 55, w - 40, 1, VoidUI.Colors.White)
        draw.SimpleText("Waffen", "VoidUI.R34", 160, 30, VoidUI.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Aufsätze", "VoidUI.R34", 480, 30, VoidUI.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    self.weaponBackgroundPanel = shopPanel:Add("VoidUI.BackgroundPanel")
    self.weaponBackgroundPanel:Dock(LEFT)
    self.weaponBackgroundPanel:DockMargin(0,70,0,10)
    self.weaponBackgroundPanel:SSetSize(shopPanel:GetWide() / 2 - 45 , 0)

    for _, wep in ipairs(LocalPlayer():GetWeapons()) do
        local className = wep:GetClass()
        if not NMG.AttachmentShop.WeaponAttachments[className] then continue end

        self.weaponPanel = self.weaponBackgroundPanel:Add("NMG.AttachmentShop.ItemDetails")
        self.weaponPanel:Dock(TOP)
        self.weaponPanel:DockMargin(0,0,0,10)
        self.weaponPanel:SetItem(className)
        self.weaponPanel.DoClick = function ()
            if IsValid(self.attachmentBackgroundPanel) then
                self.attachmentBackgroundPanel:Remove()
            end

            self.attachmentBackgroundPanel = shopPanel:Add("VoidUI.BackgroundPanel")
            self.attachmentBackgroundPanel:Dock(RIGHT)
            self.attachmentBackgroundPanel:DockMargin(0,70,0,10)
            self.attachmentBackgroundPanel:SSetSize(shopPanel:GetWide() / 2 - 45 , 0)

            for attachmentData, _ in pairs(NMG.AttachmentShop.WeaponAttachments[className]) do
                self.attachmentPanel = self.attachmentBackgroundPanel:Add("NMG.AttachmentShop.ItemDetails")
                self.attachmentPanel:Dock(TOP)
                self.attachmentPanel:DockMargin(0,0,0,10)
                self.attachmentPanel:SetItem(attachmentData)
                self.attachmentPanel:SetAttachment(true)
                self.attachmentPanel:ShopDetail(true)
                self.attachmentPanel.DoClick = function()
                    if ShoppingCart[attachmentData] then return end
                    ShoppingCart[attachmentData] = true

                    timer.Simple(0.1, function()
                        self:GetShoppingCart()
                    end)
                end
            end
        end
    end
end

function PANEL:GetShoppingCart()
    if IsValid(self.cartPanel) then
        self.cartPanel:Remove()
    end

    self.cartPanel = self:Add("VoidUI.BackgroundPanel")
    self.cartPanel:Dock(RIGHT)
    self.cartPanel:SSetSize(250, 0)
    self.cartPanel:DockMargin(15,15,15,0)
    self.cartPanel:SetTitle("Warenkorb" .. " | " .. table.Count(ShoppingCart) .. " Aufsätze")

    self.attachmentCartPanel = self.cartPanel:Add("VoidUI.BackgroundPanel")
    self.attachmentCartPanel:Dock(FILL)
    self.attachmentCartPanel:SSetSize(250, 0)
    self.attachmentCartPanel:DockMargin(0,20,0,0)

    local scrollPanel = self.attachmentCartPanel:Add("VoidUI.ScrollPanel")
    scrollPanel:Dock(FILL)

    for attachment, _ in pairs(ShoppingCart) do
        self.shoppingcart = scrollPanel:Add("NMG.AttachmentShop.ItemDetails")
        self.shoppingcart:Dock(TOP)
        self.shoppingcart:DockMargin(0,10,0,0)
        self.shoppingcart:SetItem(attachment)
        self.shoppingcart:SetAttachment(true)
        self.shoppingcart:ShoppingCartDetail(true)
    end

    self.buyButton = self.cartPanel:Add("VoidUI.Button")
    self.buyButton:Dock(BOTTOM)
    self.buyButton:DockMargin(0,0,0,10)
    self.buyButton:SSetSize(250, 35)
    self.buyButton:SetText("Kaufen")
    self.buyButton.DoClick = function()
        table.Empty(ShoppingCart)
        self:Remove()
    end
end

vgui.Register("NMG.AttachmentShop.Panel", PANEL, "VoidUI.Frame")

concommand.Add("nmg", function ()
    local frame = vgui.Create("NMG.AttachmentShop.Panel")
    frame:GetPresets()
    frame:GetAttachments()
    frame:GetShoppingCart()
end)

