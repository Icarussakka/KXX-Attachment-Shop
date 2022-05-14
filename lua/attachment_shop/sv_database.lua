local database = VoidLib.Database:Create({
    host = "localhost",
    username = "username",
    password = "password",
    database = "database",
    port = 3306,
    useMySQL = false,
})

function database:OnConnected()
    local query = database:Create("nmg_attachmenshop")
        query:Create("id", "INTEGER NOT NULL AUTO_INCREMENT")
        query:Create("steam_id", "VARCHAR(35) NOT NULL")
        query:Create("preset_id", "INTEGER")
        query:Create("preset_item", "VARCHAR(35) NOT NULL")
        query:PrimaryKey("id")
    query:Execute()
end

database:Connect()

function NMG.AttachmentShop.InsertPresetItem(steam_id, preset_id, preset_item)
    local query = database:Insert("nmg_attachmenshop")
        query:Insert("steam_id", steam_id)
        query:Insert("preset_id", preset_id)
        query:Insert("preset_item", preset_item)
    query:Execute()
end

function NMG.AttachmentShop.DeletePreset(steam_id, preset_id)
    local query = database:Delete("nmg_attachmenshop")
        query:Where("steam_id", steam_id)
        query:Where("preset_id", preset_id)
    query:Execute()
end

function NMG.AttachmentShop.SelectPresetItem(steam_id, preset_id, callback)
    local query = database:Select("nmg_attachmenshop")
        query:Where("steam_id", steam_id)
        query:Where("preset_id", preset_id)
        query:Callback(function(tblData)
            if not tblData then
                callback(nil)
                return
            end
            for _, preset in ipairs(tblData) do
                callback(preset.preset_item)
            end
        end)
    query:Execute()
end