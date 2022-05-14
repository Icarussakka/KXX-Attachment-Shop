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

timer.Simple(0, function() //darkrp du hurensohn
    NMG.AttachmentShop.WeaponAttachments = {
        ["cw_ak74"] = {
            ["cw_attpack_sights_sniper"] = true,
            ["cw_attpack_sights_cqb"] = true,
        },
        ["cw_ar15"] = {
            ["md_eotech"] = true,
            ["md_aimpoint"] = true,
            ["md_acog"] = true,
        },
    }

    NMG.AttachmentShop.ItemData = {
        // add here weapons
        ["cw_ak74"] = {
            printName = "AK-74",
            icon = " ",
            description = "Kaliber: 5.45x39mm",
        },
        ["cw_ar15"] = {
            printName = "AR-15",
            icon = " ",
            description = "Kaliber: 5.56x45mm",
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

    if CLIENT then
        NMG.AttachmentShop.FallbackIcons = {
            textureFallback = surface.GetTextureID(" "),
            materialFallback = Material(" "),
        }
    end
end)
