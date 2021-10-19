$target = $args[0]
 while (1 -eq 1){
        get-date >> ping_$target.txt
        write-host "`n"
        ping $target >> ping_$target.txt
        write-host "`n"
    }