require "app.serialization.JsonDeserialize"
local PACHIN_G2U_TAKE_MONEY_IN_ACK = class("PACHIN_G2U_TAKE_MONEY_IN_ACK", cc.JsonDeserialize:create())

function PACHIN_G2U_TAKE_MONEY_IN_ACK:ctor(content)
    self:Deserialize(content)
    --     self.TakeMoneyAck = {}
    --     self.TakeMoneyAck.money
end

cc.PACHIN_G2U_TAKE_MONEY_IN_ACK = PACHIN_G2U_TAKE_MONEY_IN_ACK