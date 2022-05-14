net.Receive("NMG.AttachmentShop.SendPresetToClient", function(len)
    local indexNumber = net.ReadUInt(5)

    print("angekommen")

    for i = 1, indexNumber do
        local attachment = net.ReadString()

        NMG.AttachmentShop.ShoppingCart[attachment] = true
    end
end)