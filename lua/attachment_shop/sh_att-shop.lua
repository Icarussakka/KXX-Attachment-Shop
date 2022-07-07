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
                    net.WriteUInt(presetID, 4)
                net.SendToServer()
            end
        },
        // Save Button
        {
            name = "Speichern",
            color = VoidUI.Colors.Green,
            buttonFunc = function(presetID, attachmentTable)
                if table.IsEmpty(attachmentTable) then
                    VoidLib.Notify("Attachment Shop", "Dein Warenkorb ist leer! Du musst diesen befüllen um etwas speichern zu können!", VoidUI.Colors.Red, 5)
                    return
                end

                net.Start("NMG.AttachmentShop.SavePreset")
                    net.WriteUInt(table.Count(attachmentTable), 5)
                    net.WriteUInt(presetID, 4)
                    for attachment, _ in pairs(attachmentTable) do
                        net.WriteString(attachment)
                    end
                net.SendToServer()
            end
        },
        // Select Button
        {
            name = "Auswählen",
            color = VoidUI.Colors.Blue,
            buttonFunc = function(presetID, attachmentTable)
                if presetID == 0 then
                    VoidLib.Notify("Attachment Shop", "Du must ein Preset auswählen!", VoidUI.Colors.Red, 5)
                    return
                end

                table.Empty(attachmentTable)

                net.Start("NMG.AttachmentShop.SelectPreset")
                    net.WriteUInt(presetID, 4)
                net.SendToServer()
            end
        },
    }
end)

timer.Simple(0, function()
    NMG.AttachmentShop.ItemData = {
        // add here weapons
        ["cw_ak74"] = "nmg-lmg.png",
        ["cw_ar15"] = "nmg-sturmgewehr.png",
        ["cw_l115"] = "nmg-sniper.png",
        ["cw_g3a3"] = "nmg-shotgun.png",

        // add here attachments
        ["md_eotech"] = 300,
        ["md_aimpoint"] = 600,
        ["md_acog"] = 200,
    }

    NMG.AttachmentShop.FallbackPrice = 250
    NMG.AttachmentShop.FallbackIcon = "nmg-sturmgewehr.png"
    NMG.AttachmentShop.EntityModel = "models/props_c17/display_cooler01a.mdl"
end)

