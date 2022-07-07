net.Receive("KXX.AttachmentShop.SendPresetToClient", function(len)
    local indexNumber = net.ReadUInt(5)

    for i = 1, indexNumber do
        local attachment = net.ReadString()

        KXX.AttachmentShop.ShoppingCart[attachment] = true
    end
end)