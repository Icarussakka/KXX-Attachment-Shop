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

timer.Simple(0, function() //darkrp du hurensohn
    NMG.AttachmentShop.WeaponAttachments = {
        ["cw_ak74"] = {
            ["md_eotech"] = true,
        },
        ["cw_ar15"] = {
            ["md_eotech"] = true,
            ["md_aimpoint"] = true,
            ["md_acog"] = true,
        },
        ["cw_l115"] = {

        },
        ["cw_g3a3"] = {

        }
    }

    NMG.AttachmentShop.ItemData = {
        // add here weapons
        ["cw_ak74"] = {
            printName = "AK-74",
            icon = "nmg-lmg.png",
            description = "Kaliber: 5.45x39mm",
        },
        ["cw_ar15"] = {
            printName = "AR-15",
            icon = "nmg-sturmgewehr.png",
            description = "Kaliber: 5.56x45mm",
        },
        ["cw_l115"] = {
            printName = "Sniper",
            icon = "nmg-sniper.png",
            description = "Kaliber: 50 BMG",
        },
        ["cw_g3a3"] = {
            printName = "Shotgun",
            icon = "nmg-shotgun.png",
            description = "Kaliber: Schrot",
        },


          // add here attachments
        ["md_eotech"] = {
            printName = "EoTech",
            price = 500,
            icon = "atts/eotech553",
            description = "Preis | " .. DarkRP.formatMoney(500),
        },
        ["md_aimpoint"] = {
            printName = "Aimpoint",
            price = 1800,
            icon = "atts/compm4",
            description = "Preis | " .. DarkRP.formatMoney(1800),
        },
        ["md_acog"] = {
            printName = "ACOG",
            price = 100,
            icon = "atts/acog",
            description = "Preis | " .. DarkRP.formatMoney(100),
        },
    }

    NMG.AttachmentShop.EntityModel = "models/props_c17/display_cooler01a.mdl"
end)
