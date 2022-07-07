net.Receive("KXX.AttachmentShop.BuyAttachments", function(len, ply)
    local shoppingCart = shoppingCart or {}
    local indexNumber = net.ReadUInt(5)

    for i = 1, indexNumber do
        local attachment = net.ReadString()

        shoppingCart[attachment] = true
    end

    local attachmentPrice = 0
    for attachment, _ in pairs(shoppingCart) do
        attachmentPrice = attachmentPrice + (KXX.AttachmentShop.ItemData[attachment] or KXX.AttachmentShop.FallbackPrice)
    end

    local hasMoney = ply:canAfford(attachmentPrice)
    if not hasMoney then return end

    for attachment, _ in pairs(shoppingCart) do
        CustomizableWeaponry.giveAttachments(ply, {attachment})
    end

    ply:addMoney(-attachmentPrice)
    VoidLib.Notify(ply, "Aufsatz Shop", "Du hast Aufsätze im Wert von " .. DarkRP.formatMoney(attachmentPrice) .. " gekauft!", VoidUI.Colors.Green, 5)
end)

net.Receive("KXX.AttachmentShop.SavePreset", function(len, ply)
    local shoppingCart = shoppingCart or {}
    local indexNumber = net.ReadUInt(5)
    local presetID = net.ReadUInt(4)

    for i = 1, indexNumber do
        local attachment = net.ReadString()

        shoppingCart[attachment] = true
    end

    KXX.AttachmentShop.SelectPresetItem(ply:SteamID64(), presetID, function(presetItem)
        if presetItem then
            VoidLib.Notify(ply, "Aufsatz Shop", "Auf diesem Presets ist bereits etwas gespeichert!", VoidUI.Colors.Red, 5)
            return
        end

        for attachment, _ in pairs(shoppingCart) do
            KXX.AttachmentShop.InsertPresetItem(ply:SteamID64(), presetID, attachment)
        end

        VoidLib.Notify(ply, "Aufsatz Shop", "Du hast erfolgreich das Preset " .. presetID .. " gespeichert.", VoidUI.Colors.Green, 5)
    end)
end)

net.Receive("KXX.AttachmentShop.DeletePreset", function(len, ply)
    local presetID = net.ReadUInt(4)

    KXX.AttachmentShop.SelectPresetItem(ply:SteamID64(), presetID, function(presetItem)
        if not presetItem then
            VoidLib.Notify(ply, "Aufsatz Shop", "Auf diesem Preset ist nichts gespeichert.", VoidUI.Colors.Red, 5)
            return
        end

        KXX.AttachmentShop.DeletePreset(ply:SteamID64(), presetID)

        VoidLib.Notify(ply, "Aufsatz Shop", "Du hast erfolgreich das Preset " .. presetID .. " gelöscht.", VoidUI.Colors.Green, 5)
    end)
end)

net.Receive("KXX.AttachmentShop.SelectPreset", function(len, ply)
    local shoppingCart = shoppingCart or {}
    local presetID = net.ReadUInt(4)

    KXX.AttachmentShop.SelectPresetItem(ply:SteamID64(), presetID, function(presetItem)
        if not presetItem then
            VoidLib.Notify(ply, "Aufsatz Shop", "Auf diesem Preset ist nichts gespeichert.", VoidUI.Colors.Red, 5)
            return
        end

        shoppingCart[presetItem] = true
    end)

    net.Start("KXX.AttachmentShop.SendPresetToClient")
        net.WriteUInt(table.Count(shoppingCart), 5)
        for attachment, _ in pairs(shoppingCart) do
            net.WriteString(attachment)
        end
    net.Send(ply)
end)