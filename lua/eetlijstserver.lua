print('create server')
srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
conn:on("receive", function(client,payload)

 tmr.stop(1)
 
 tgtfile = string.sub(payload,string.find(payload,"GET /")+5,string.find(payload,"HTTP/")-2)
 print(tgtfile)
 if string.match(tgtfile, 'eetlogin', 0) then
 login = string.sub(tgtfile,string.find(tgtfile,"eetlogin=")+9,string.find(tgtfile,"&eetpw")-1)
 eetpw = string.sub(tgtfile,string.find(tgtfile,"eetpw=")+6) 
    local f = file.open("fileloc.txt", "w+")
    file.writeline(login.."-"..eetpw)
    file.close()
    tgtfile = "doneeetlijst.html"
    f = file.open(tgtfile,"r")
    print('client send the file')
    client:send(file.read())
    print('file close')
    file.close()
    print('client close') 
    client:close();
    print('client closed') 
    collectgarbage();
    f = nil
    tgtfile = nil 

    dofile("openeetlijst.lua")
 
 else
 if tgtfile == "" then tgtfile = "eetlijst.html" end 
    print('file')
    print(tgtfile) 
    local f = file.open(tgtfile,"r")
 
    if f ~= nil then
        print('client send 2') 
        client:send(file.read())
        file.close()
    else
        print('conn send 2') 
        conn:send("HTTP/1.1 404 file not found")
        return
    end
    print('client close 2') 
    client:close();
    collectgarbage();
    f = nil
    tgtfile = nil
 end
 tmr.alarm(1, 300000, 1, function ()
    dofile("openeetlijst.lua")
 end)
 end)
end)



