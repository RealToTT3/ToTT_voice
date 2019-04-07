local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local voice = {default = 5.0, shout = 12.0, whisper = 1.0, current = 0}
local r,g,b,a = {} 
local playerNamesDist = 10

AddEventHandler('onClientMapStart', function()
	NetworkSetTalkerProximity(voice.default)
end)

function Marker(type, x, y, z, voice1)
    DrawMarker(type, x, y, z - 1.2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, voice1, voice1, 1.0, r, g, b, a, false, true, 2, false, false, false, false)
end

Citizen.CreateThread(function()
    local sleep = 0

    if config.cooler == "pink" then
        r,g,b,a = 246, 0, 145, 255
    elseif config.cooler == "green" then
        r,g,b,a = 0, 153, 38, 255
    elseif config.cooler == "blue" then
        r,g,b,a = 0, 0, 204, 255
    elseif config.cooler == "white" then
        r,g,b,a = 255, 255, 255, 255
    end
    Citizen.Wait(sleep)   
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 0
        local coords = GetEntityCoords(PlayerPedId())
        if IsControlJustPressed(0, Keys['H']) and IsControlPressed(0, Keys['LEFTSHIFT']) then
            voice.current = (voice.current + 1) % 3
            if voice.current == 0 then
                NetworkSetTalkerProximity(voice.default)
            elseif voice.current == 1 then
                NetworkSetTalkerProximity(voice.shout)
            elseif voice.current == 2 then
                NetworkSetTalkerProximity(voice.whisper)
            end
        end
        if IsControlPressed(0, Keys['H']) and IsControlPressed(0, Keys['LEFTSHIFT']) then
            if voice.current == 0 then
                voice1 = voice.default
            elseif voice.current == 1 then
                voice1 = voice.shout
            elseif voice.current == 2 then
                voice1 = voice.whisper
            end
            Marker(1, coords.x, coords.y, coords.z, voice1 * 2.0)
        end
        Citizen.Wait(sleep)
    end
end)
