$target = $args[0]
while($true)
{
     $i++
     write-host -BackgroundColor red -foregroundcolor white "tracing target: $target ----- starting loop $i"
     echo "---------------------Loop:$i---------------------------" >> trace_$target.txt
     get-date >> trace_$target.txt
     tracert $target >> trace_$target.txt
     sleep 5
}