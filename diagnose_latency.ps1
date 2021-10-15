$target = "8.8.8.8"
while($true)
{
     $i++
     write-host "starting loop $i"
     echo "---------------------Loop:$i---------------------------" >> trace_$target.txt
     get-date >> trace_$target.txt
     tracert $target >> trace_$target.txt
     sleep 5
}