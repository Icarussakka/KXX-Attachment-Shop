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
        self.presets.DoClick = function()
            RunConsoleCommand("NMG.AttachmentShop.Preset", i)
        end
    end

    for _, buttonData in ipairs(NMG.AttachmentShop.PresetButton) do
        self.presetButton = self.presetPanel:Add("VoidUI.Button")
        self.presetButton:Dock(BOTTOM)
        self.presetButton:DockMargin(15,15,0,10)
        self.presetButton:SSetSize(250, 35)
        self.presetButton:SetColor(buttonData.color)
        self.presetButton:SetText(buttonData.name)
    end
end

function PANEL:GetAttachments()
    
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
    frame:GetShoppingCart()
end)