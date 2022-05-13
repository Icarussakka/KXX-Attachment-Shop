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

NMG.AttachmentShop.WeaponAttachments = {
    ["cw_ak74"] = {
    },
    ["cw_ar15"] = {
    },
}

