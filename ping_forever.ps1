$target = $args[0]
if (!$target){
    write-host "Usage: ping_forever.ps1 targetip"
    write-host "Will output ping_targetip.txt in same folder and continuously timestamp and ping 4 times"
}
else {
    while (1 -eq 1){
        get-date >> ping_$target.txt
        write-host "`n"
        ping $target >> ping_$target.txt
        write-host "`n"
    }   
}
 