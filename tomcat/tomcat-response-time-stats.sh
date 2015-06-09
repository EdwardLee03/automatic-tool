#!/usr/bin/env bash

### ========================
### API 请求响应时间统计
### ========================

# Tomcat access.log 日志格式
#192.168.6.5 - [08/May/2015:17:36:54 +0800] "POST /riskService?partner_code=nonobank&seq_id=1431077815098-20153063 HTTP/1.1 seq_id=1431077814410-72896722 partner_code=nonobank"
#405 166 "request_time=0.001" "-" "-" "partner_code=nonobank&app_name=nonobank&secret_key=73aa950c420b45b3916152d079d37a29&token_id=NNvlef0jmo6214a9thotutogpor0&
#ip_address=180.107.60.233&user_agent_cust=Mozilla%2F5.0+%28Windows+NT+6.3%3B+WOW64%29+AppleWebKit%2F537.36+%28KHTML%2C+like+Gecko%29+Chrome%2F40.0.2214.10+Safari%2F537.36&0=0&1=200&event_id=api_acl&account_mobile=18913673333"

log_file="$1"

#echo "Log File: $log_file"

if [ -z "$log_file" ] ; then
    echo "Usage: tomcat-response-time-stats.sh log_file";
    exit;
fi

awk -F\" '{ print $4; }' "$log_file" | awk 'BEGIN { FS="="; sum=0; count=0; max=0; oneSec=0; tenMillis=0; print "\n\n------ api response time statistics ------"; } \
 { sum+=$2; count+=1; if ($2>max) max=$2; if ($2>1) oneSec+=1; if ($2>0.01) tenMillis+=1; } \
END { avgTime=sum/count; print "Average Time: " avgTime ", Max: " max ", Sum: " sum ", Count: " count \
", >1s: " oneSec ", >10ms: " tenMillis "\n"; }'
