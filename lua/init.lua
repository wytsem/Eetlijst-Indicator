function onboardserver()
print('run server')
dofile("onboardserver.lua")
end

uart.setup(0,115200,8,0,1,1)

print('wif mode')
print(wifi.getmode())
count=0

ws2812.writergb(4, string.char(0, 0, 0):rep(4))
ws2812.writergb(4, string.char(10, 0, 0):rep(1))

tmr.alarm(1,1000, 1, function() 
 print('.')
 if wifi.sta.getip()==nil then 
    if count == 5 then
        print('onboard server to request WIFI details in 3 secs')
        ipfail = true
        tmr.stop(1) 
        if(wifi.getmode() ~= 3) then
            print('changing wifi mode to station')
            wifi.setmode(wifi.STATIONAP);
        end
        tmr.alarm(0,3000,0,onboardserver)
    else
        count = count + 1 
    end
 else 
    print(wifi.sta.getip())
    if(wifi.getmode() ~= 1) then
        print('changing wifi mode to station only')
        wifi.setmode(wifi.STATION);
    end
    tmr.stop(0) 
    count = nil
    collectgarbage();
    dofile("eetlijstserver.lua")
    dofile("openeetlijst.lua")
    tmr.alarm(1, 300000, 1, function ()
        dofile("openeetlijst.lua")
    end)
 end 
end)
