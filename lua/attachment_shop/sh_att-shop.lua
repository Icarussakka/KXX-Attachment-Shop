hook.Add("VoidLib.Loaded", "NMG.AttShop.watingForVoidlib", function()
    NMG.AttachmentShop.PresetButton = {
        //Delete Button
        {
            name = "Löschen",
            color = VoidUI.Colors.Red,
            buttonFunc = function(presetID)
                if presetID == 0 then
                    VoidLib.Notify("Attachment Shop", "Du must ein Preset auswählen!", VoidUI.Colors.Red, 5)
                    return
                end

                net.Start("NMG.AttachmentShop.DeletePreset")
                    net.WriteUInt(presetID, 3)
                net.SendToServer()
            end
        },
        // Save Button
        {
            name = "Speichern",
            color = VoidUI.Colors.Green,
            buttonFunc = function(presetID, attachmentTable)
                // coming
            end
        },
        // Select Button
        {
            name = "Auswählen",
            color = VoidUI.Colors.Blue,
            buttonFunc = function()
                // coming
            end
        },
    }
end)

NMG.AttachmentShop.WeaponAttachments = {
    ["cw_ak74"] = {
    },
    ["cw_ar15"] = {
    },
}

NMG.AttachmentShop.ItemData = {
    ["cw_ak74"] = {
        printName = "AK-74",
        description = "Kaliber: 5.45x39mm",
    },
    ["cw_ar15"] = {
        printName = "AR-15",
        description = "Kaliber: 5.56x45mm",
    },
}