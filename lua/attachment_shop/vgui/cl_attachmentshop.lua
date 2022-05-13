local PANEL = {}

function PANEL:Init()
    self:SSetSize(1300, 850)
    self:Center()
    self:SetTitle("Aufsatz Händler")
    self:MakePopup()
end

function PANEL:GetPresets()
    CreateConVar("NMG.AttachmentShop.Preset", 0, FCVAR_NONE)

    self.presetPanel = self:Add("VoidUI.BackgroundPanel")
    self.presetPanel:Dock(LEFT)
    self.presetPanel:SSetSize(250, 0)
    self.presetPanel:DockMargin(15,15,15,15)

    for i = 1, 8 do // TODO : add cfg var
        self.presets = self.presetPanel:Add("VoidUI.Button")
        self.presets:Dock(TOP)
        self.presets:DockMargin(15,15,10,0)
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
    local attachmentPanel = self:Add("VoidUI.BackgroundPanel")
    attachmentPanel:Dock(LEFT)
    attachmentPanel:SSetSize(740, 0)
    attachmentPanel:DockMargin(0,15,0,15)
    attachmentPanel.Paint = function (s, w, h)
        // draws the white lines and the text
        draw.RoundedBox(12, 0, 0, w, h, VoidUI.Colors.Primary)
        draw.RoundedBox(0, w / 2, 75, 1, h - 95 , VoidUI.Colors.White)
        draw.RoundedBox(0, 20, 55, w - 40, 1, VoidUI.Colors.White)
        draw.SimpleText("Waffen", "VoidUI.R34", 160, 30, VoidUI.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Aufsätze", "VoidUI.R34", 480, 30, VoidUI.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    self.weaponPanel = attachmentPanel:Add("VoidUI.BackgroundPanel")
    self.weaponPanel:Dock(LEFT)
    self.weaponPanel:DockMargin(10,70,10,10)
    self.weaponPanel:SSetSize(attachmentPanel:GetWide() / 2 - 45 , 0)
    self.weaponPanel.Paint = function (s,w,h)
        draw.RoundedBox(12, 0, 0, w, h, VoidUI.Colors.White)
    end

end

function PANEL:GetShoppingCart()
    self.cartPanel = self:Add("VoidUI.BackgroundPanel")
    self.cartPanel:Dock(RIGHT)
    self.cartPanel:SSetSize(250, 0)
    self.cartPanel:DockMargin(15,15,15,15)
end

vgui.Register("NMG.AttachmentShop.Panel", PANEL, "VoidUI.Frame")

concommand.Add("nmg", function ()
    local frame = vgui.Create("NMG.AttachmentShop.Panel")
    frame:GetPresets()
    frame:GetAttachments()
    frame:GetShoppingCart()
end)