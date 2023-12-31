require "cocos.cocos2d.json"
local JsonDeserialize = class("JsonDeserialize")

function JsonDeserialize:Deserialize(content)
    local success, data = pcall(json.decode, content)
    if success then
        for key, value in pairs(data) do
            print("Deserialize.Result:", key, value)
            self[key] = value
        end
    else
        print("JsonDeserialize:json DeSerialize fail!", content)
    end
    --dump(data)
end

cc.JsonDeserialize = JsonDeserialize