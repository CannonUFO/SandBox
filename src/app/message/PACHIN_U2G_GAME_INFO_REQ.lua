require("app.serialization.JsonSerialize")

local PACHIN_U2G_GAME_INFO_REQ = class("PACHIN_U2G_GAME_INFO_REQ", cc.JsonSerialize:create())
function PACHIN_U2G_GAME_INFO_REQ:ctor(accountId, roomIndex)
    self.loginData = {}
    self.loginData.accountId = accountId
    self.loginData.roomIndex = roomIndex
end

cc.PACHIN_U2G_GAME_INFO_REQ = PACHIN_U2G_GAME_INFO_REQ

