$target = $args[0]
if (!$target){
     write-host "Usage: diagnose_latency.ps1 targetip"
     write-host "Will run continuous timestamped traceroutes to targetip and output trace_targetip.txt in same directory"
 }
 else {
while($true){
     $i++
     write-host -BackgroundColor red -foregroundcolor white "tracing target: $target ----- starting loop $i"
     echo "---------------------Loop:$i---------------------------" >> trace_$target.txt
     get-date >> trace_$target.txt
     tracert $target >> trace_$target.txt
     sleep 5
     }
 }