local PluginProgram = class( "PluginProgram" ) 
PluginProgram.__index = PluginProgram

PluginProgram.m_isMute = false

local ERROR_DEFINE = {
	NONE = 0,
}

local GAME_STATUS = {
	BETWAIT = 0,        -- Waiting for MaxBet button to be pressed
	LEVERWAIT = 1,      -- Waiting for the lever to be pressed
	ROTATEWAIT = 2,     -- waiting for the start of rotation
	STOPWAIT_1 = 3,     -- Waiting for the stop button to be pressed
	STOPWAIT_2 = 4,     -- Waiting for the stop button to be pressed
	STOPWAIT_3 = 5,     -- Waiting for the stop button to be pressed
	ALLREELSTOP = 6,    -- Waiting for all reels to stop
	PAYOUT = 7,         -- paying out
	GAMEEND = 8,        -- End of one game
	AUTO_PLAY = 9,      -- Normal Auto
	AUTO_ITEM = 10,     -- Auto during item use
}

local RUN_KIND = {
	NORMAL = 0,         -- Normal
	ASSIST_TIME = 1,    -- Assist Time
	INFO_SETTING = 2,   -- Infomation or Setting Menu
}

function PluginProgram:extend( target )
	setmetatable( target, PluginProgram )
	return target
end

function PluginProgram:create()
	return PluginProgram:extend( {} )
end

function PluginProgram:Init( sourcePath )
	print("PluginProgram:Init() sourcePath:", sourcePath)

	local testInt = Inanna.GetJoyTube().m_testInt
    print("Inanna.GetJoyTube().m_testInt", testInt)

	Inanna.GetJoyTube():SetSourcePath( sourcePath )

	local left = 0
	local top = 0
	local width = CC_DESIGN_RESOLUTION.width
	local height = CC_DESIGN_RESOLUTION.height -- 可能要減掉NavigationView
	local useLocal = true
	Inanna.GetJoyTube():InitPlugin( left, top, width, height, useLocal )

	self:RegisterCreditEventCB()
	self:RegisterErrorStatusCB()
end

function PluginProgram:OnLeaveGame()
	Inanna.GetJoyTube():OnLeaveGame()
end

function PluginProgram:SetMusicMute( isMute )
	if self.m_isMute == isMute then return end

	self.m_isMute = isMute
	Inanna.GetJoyTube():SetMusicMute( isMute )
end

function PluginProgram:GetMusicMute()
	return self.m_isMute
end

function PluginProgram:RegisterCreditEventCB()
	local function cb( chip )
		cc.exports.dispatchEvent( cc.exports.define.EVENTS.CHIP_UPDATE, chip )
	end
	Inanna.GetJoyTube():RegisterCreditEventCB( cb )
end

function PluginProgram:RegisterErrorStatusCB()
	local function cb( errorStatus )
		-- NET_DELAY = 8
		-- INSUFFICIENT_BALANCE = 6 多執行一次 ResetErrorStatus (?)

		Inanna.GetJoyTube():ResetErrorStatus()
		cc.exports.dispatchEvent( cc.exports.define.EVENTS.PLUGIN_ERROR_STATUS, errorStatus )
	end
	Inanna.GetJoyTube():RegisterErrorStatusCB( cb )
end

function PluginProgram:GetGameStatus()
	return Inanna.GetJoyTube():GetGameStatus()
end

function PluginProgram:GetPlayState()
	local playState = Inanna.GetJoyTube():GetPlayState()
	if Inanna.GetJoyTube():IsEnteringSetting() then
		playState = RUN_KIND.INFO_SETTING
	end
	return playState
end

function PluginProgram:Abort()
	Inanna.GetJoyTube():Abort()
end

cc.exports.PluginProgram = PluginProgram
cc.exports.PluginProgram.ERROR_DEFINE = ERROR_DEFINE
cc.exports.PluginProgram.GAME_STATUS = GAME_STATUS
cc.exports.PluginProgram.RUN_KIND = RUN_KIND