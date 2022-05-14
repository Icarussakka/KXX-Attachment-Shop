net.Receive("NMG.AttachmentShop.BuyAttachments", function(len, ply)
    local shoppingCart = shoppingCart or {}
    local indexNumber = net.ReadUInt(5)

    for i = 1, indexNumber do
        local attachment = net.ReadString()

        shoppingCart[attachment] = true
    end

    local attachmentPrice = 0
    for attachment, _ in pairs(shoppingCart) do
        attachmentPrice = attachmentPrice + NMG.AttachmentShop.ItemData[attachment].price
    end

    local hasMoney = ply:canAfford(attachmentPrice)
    if not hasMoney then return end

    for attachment, _ in pairs(shoppingCart) do
        CustomizableWeaponry.giveAttachments(ply, {attachment});
    end

    ply:addMoney(-attachmentPrice)
    VoidLib.Notify(ply, "Aufsatz Shop", "Du hast Aufsätze im Wert von " .. DarkRP.formatMoney(attachmentPrice) .. " gekauft!", VoidUI.Colors.Green, 5)
end)