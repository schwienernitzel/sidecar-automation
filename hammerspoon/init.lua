local VENDOR_ID  = 0x05ac
local PRODUCT_ID = 0x12ab
local SCRIPT     = os.getenv("HOME") .. "/sc-hax/AppleScript/run.applescript"

local function runScript()
    local file = io.open(SCRIPT, "r")
    if not file then
        hs.notify.new({title="sc-hax", informativeText="Script not found: " .. SCRIPT}):send()
        return
    end
    local source = file:read("*a")
    file:close()
    local ok, err = hs.osascript.applescript(source)
    if not ok then
        hs.notify.new({title="sc-hax", informativeText="Error: " .. tostring(err)}):send()
    end
end

local usbWatcher = hs.usb.watcher.new(function(event)
    if event.vendorID == VENDOR_ID and event.productID == PRODUCT_ID then
        if event.eventType == "added" then
            hs.timer.doAfter(6, runScript)
        end
    end
end)

hs.timer.doAfter(10, function()
    usbWatcher:start()
    hs.notify.new({title="sc-hax", informativeText="Start"}):send()
end)
