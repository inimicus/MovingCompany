-- -----------------------------------------------------------------------------
-- Moving Company
-- Author:  g4rr3t
-- Created: Aug 19, 2018
--
-- Main.lua
-- -----------------------------------------------------------------------------

MVC             = {}
MVC.name        = "MovingCompany"
MVC.version     = "0.0.1"
MVC.dbVersion   = 1
MVC.slash       = "/mvc"
MVC.prefix      = "[MVC] "

-- -----------------------------------------------------------------------------
-- Level of debug output
-- 1: Low    - Basic debug info, show core functionality
-- 2: Medium - More information about skills and addon details
-- 3: High   - Everything
MVC.debugMode = 1
-- -----------------------------------------------------------------------------

function MVC:Trace(debugLevel, ...)
    if debugLevel <= MVC.debugMode then
        d(MVC.prefix .. ...)
    end
end

-- -----------------------------------------------------------------------------
-- Startup
-- -----------------------------------------------------------------------------

function MVC.Initialize(event, addonName)
    if addonName ~= MVC.name then return end

    MVC:Trace(1, "Moving Company Loaded")
    EVENT_MANAGER:UnregisterForEvent(MVC.name, EVENT_ADD_ON_LOADED)

    MVC.saved = ZO_SavedVars:NewAccountWide("MovingCompanyVariables", MVC.dbVersion, nil, MVC:GetDefaults())

    -- Use saved debugMode value if the above value has not been changed
    if MVC.debugMode == 0 then
        MVC.debugMode = MVC.saved.debugMode
        MVC:Trace(1, "Setting debug value to saved: " .. MVC.saved.debugMode)
    end

    SLASH_COMMANDS[MVC.slash] = MVC.SlashCommand

    MVC:Trace(2, "Finished Initialize()")
end

-- -----------------------------------------------------------------------------
-- Event Hooks
-- -----------------------------------------------------------------------------

EVENT_MANAGER:RegisterForEvent(MVC.name, EVENT_ADD_ON_LOADED, function(...) MVC.Initialize(...) end)

