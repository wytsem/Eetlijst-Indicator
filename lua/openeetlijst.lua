-- retrieve the weather from openweathermap

conn=net.createConnection(net.TCP, 0) 

conn:on("connection",function(conn, payload)
    local f = file.open("fileloc.txt", "r")
    login = string.sub(file.readline(), 1, -1)
    file.close()
    conn:send("GET /mobiel.php?"..login.." HTTP/1.1\r\nHost: eetlijst.nl\r\nConnection: keep-alive\r\nAccept: */*\r\n\r\n")     
    f = nil
    login = nil  
    collectgarbage();
 end)
 
conn:on("receive", function(conn, payload)

index = string.find(payload,"<tr>") 
tmr.stop(2)
if index == nil then
    ws2812.writergb(4, string.char(0, 0, 0):rep(4))
    tmr.alarm(2, 500, 1, function ()
        ws2812.writergb(4, string.char(255, 0, 0))
        tmr.delay(100000)
        ws2812.writergb(4, string.char(0, 0, 0))
    end)
else

index = index + 6
RGB = ''

if index ~= nil then
	while true do 
		check = string.find(payload,"value=",index)
		if check == nil then
			name = string.sub(payload, index + 2,string.find(payload,"</td>",index)-1)
		else
			name = string.sub(payload,string.find(payload,"value=",index)+7,string.find(payload,"</td>",index)-3)  
		end
		index = string.find(payload,"</td>",index)
		state = string.sub(payload,string.find(payload,"<td>",index)+4,string.find(payload,"</td>",index+4)-1)
		print(name.. ' '..state)

		check = string.find(state,"kook")
		if check ~= nil then
			RGB = RGB.. string.char(255, 0, 0)
		else
			check = string.find(state,"eet")
			if check ~= nil then
				RGB = RGB.. string.char(0, 255, 0)
			end
		end

		check = string.find(state,"nop")
		if check ~= nil then
			RGB = RGB.. string.char(0, 0, 127)
		end

		if state == '' then
			RGB = RGB.. string.char(0, 0, 0)
		end
    
		index = string.find(payload,"<tr>", index+1) 
		if index == nil then
			break
		end
		index = index + 6
	end
end
ws2812.writergb(4, RGB)
end

 RGB= nil
 index = nil
 check = nil
 conn:close()
 collectgarbage();
 end) 

 if wifi.sta.getip()==nil then
    node.restart()
 end

conn:connect(80,'eetlijst.nl') 

