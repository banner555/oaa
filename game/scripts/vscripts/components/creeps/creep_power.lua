if CreepPower == nil then
  DebugPrint ( 'Creating new CreepPower object...' )
  CreepPower = class({})
end

function CreepPower:GetPowerForMinute (minute)
  local multFactor = 1

  if minute == 0 then
    return {   0,        1.0,      1.0,      1.0,      1.0,      1.0,      1.0 * self.numPlayersXPFactor}
  end

  if minute > 60 then
    multFactor = 1.5 ^ (minute - 60)
  end

  return {
    minute,                                   -- minute
    (45 * ((minute / 100) ^ 4) - 36 * ((minute/100) ^ 3) + 21 * ((minute/100) ^ 2) - 1.5 * (minute/100)) + 1,   -- hp
    (45 * ((minute / 100) ^ 4) - 36 * ((minute/100) ^ 3) + 21 * ((minute/100) ^ 2) - 1.5 * (minute/100)) + 1,   -- mana
    (240 * ((minute / 100) ^ 4) - 192 * ((minute/100) ^ 3) + 112 * ((minute/100) ^ 2) - 8 * (minute/100)) + 1,     -- damage
    (minute / 20) ^ 2 + minute / 6 + 1,       -- armor
    (minute / 2) + 1,                         -- gold
    ((21 * minute^2 - 19 * minute + 3002) / 3002) * self.numPlayersXPFactor * multFactor -- xp
  }
end

function CreepPower:Init ()
  local maxTeamPlayerCount = 10 -- TODO: Make maxTeamPlayerCount based on values set in settings.lua (?)
  self.numPlayersXPFactor = PlayerResource:GetTeamPlayerCount() / maxTeamPlayerCount
end
