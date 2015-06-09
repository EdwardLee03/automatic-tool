#!/usr/bin/env bash

### ========================
### API 请求响应时间统计（从 Nginx 端开始计时）
###
### 示例：
###      sh nginx-response-time-stats.sh api.ssl_access_20150518.log
###
### ========================

# Nginx 访问日志
#    log_format  main  '$remote_addr - [$time_local] "seq_id=$arg_seq_id partner_code=$arg_partner_code" '
#                      '$status $body_bytes_sent '
#                      '"$request_time" "$upstream_response_time" "$upstream_addr"';
###
#121.40.30.188 - [19/May/2015:00:00:02 +0800] "seq_id=1431964801926-83065189 partner_code=koudai"200 2296 "0.082" "0.050" "192.168.47.67:8088"
#
### 输出结果：
#------ api response time statistics ------
#Average Time: 0.0655138, Sum: 116877, Count: 1784010, Max: 6.906
#<50ms: 851378
#<100ms: 644664
#<200ms: 249560
#<300ms: 33994
#<500ms: 2949
#<1s: 640
#>1s: 825

log_file="$1"

if [ -z "$log_file" ] ; then
    echo "Usage: nginx-response-time-stats.sh log_file"
    exit
fi

awk -F\" '{ print $4; }' "$log_file" | awk 'BEGIN { sum=0; count=0; max=0; \
lessThan50MillisCounter=0; lessThan100MillisCounter=0; \
lessThan200MillisCounter=0; lessThan300MillisCounter=0; \
lessThan500MillisCounter=0; lessThan1SecCounter=0; moreThan1SecCounter=0; \
print "\n\n------ api response time statistics ------"; } \
{ sum+=$1; count+=1; if ($1>max) max=$1; \
if ($1<0.05) { lessThan50MillisCounter+=1; } else if ($1<0.1) { lessThan100MillisCounter+=1; } \
else if ($1<0.2) { lessThan200MillisCounter+=1; } else if ($1<0.3) { lessThan300MillisCounter+=1; } \
else if ($1<0.5) { lessThan500MillisCounter+=1; } else if ($1<1) { lessThan1SecCounter+=1; } \
else { moreThan1SecCounter+=1; } \
} \
END { avgTime=sum/count; \
print "Average Time: " avgTime ", Sum: " sum ", Count: " count ", Max: " max "\n" \
"<50ms: " lessThan50MillisCounter "\n" \
"<100ms: " lessThan100MillisCounter "\n" \
"<200ms: " lessThan200MillisCounter "\n" \
"<300ms: " lessThan300MillisCounter "\n" \
"<500ms: " lessThan500MillisCounter "\n" \
"<1s: " lessThan1SecCounter "\n" \
">1s: " moreThan1SecCounter "\n" \
; }'
