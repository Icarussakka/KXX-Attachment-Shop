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
        ["cw_attpack_sights_sniper"] = true,
        ["cw_attpack_sights_cqb"] = true,
    },
    ["cw_ar15"] = {
        ["cw_attpack_sights_cqb"] = true,
        ["cw_attpack_sights_sniper"] = true,
        ["cw_attpack_ak74_barrels"] = true,
    },
}

NMG.AttachmentShop.ItemData = {
    // add here weapons
    ["cw_ak74"] = {
        printName = "AK-74",
        --icon = "",
        description = "Kaliber: 5.45x39mm",
    },
    ["cw_ar15"] = {
        printName = "AR-15",
        --icon = "",
        description = "Kaliber: 5.56x45mm",
    },

    // add here attachments
    ["cw_attpack_sights_sniper"] = {
        printName = "Scharfschützen Visiere",
        description = "Für AR-15 und AK-47 P",
    },
    ["cw_attpack_sights_cqb"] = {
        printName = "Normale Visiere",
        description = "Für AR-15 und AK-47",
    },
    ["cw_attpack_ak74_barrels"] = {
        printName = "Mieser barrel",
        description = "Für AR-15",
    },
}

if CLIENT then
    NMG.AttachmentShop.FallbackIcons = {
        textureFallback = surface.GetTextureID(" "),
        materialFallback = Material(" "),
    }
end