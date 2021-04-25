#!/usr/bin/env bash

HELP(){
    cat << EOF
    Description:
    A text batch script written with Bash
    Usage:
    bash ${0} [Options]
    Avaliable options:
    -h          Show this help text.
    -o          输出访问来源主机TOP 100和分别对应出现的总次数          
    -p          输出访问来源主机TOP 100 IP和分别对应出现的总次数
    -u          统计最频繁被访问的URL TOP 100         
    -c          统计不同响应状态码的出现次数和对应百分比
    -f          分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数
    -s          给定URL输出TOP 100访问来源主机
EOF
    return
}

# 统计访问来源主机TOP 100和分别对应出现的总次数
get_top100_host (){
    printf "%40s\t%s\n" "TOP100_host" "count"
    awk -F "\t" '
    NR>1 {
        host[$1]++;
        }
    END { 
        for(i in host) {
            printf("%40s\t%d\n",i,host[i]);
            } 
            }
    ' web_log.tsv | sort -g -k 2 -r | head -100
}
# 统计访问来源主机TOP 100 IP和分别对应出现的总次数
get_top100_IP (){
    printf "%20s\t%s\n" "TOP100_IP" "count"
    awk -F "\t" '
    NR>1 {if(match($1, /^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$/)) ip[$1]++;}
    END { for(i in ip) {printf("%20s\t%d\n",i,ip[i]);} }
    ' web_log.tsv | sort -g -k 2 -r | head -100
}
# 统计最频繁被访问的URL TOP 100
get_top100_URL (){
    printf "%55s\t%s\n" "TOP100_URL" "count"
    awk -F "\t" '
    NR>1 {url[$5]++;}
    END { for(i in url) {printf("%55s\t%d\n",i,url[i]);} }
    ' web_log.tsv | sort -g -k 2 -r | head -100
}
# 统计不同响应状态码的出现次数和对应百分比
get_stateCode (){
    awk -F "\t" '
    BEGIN {printf("code\tcount\tpercentage\n");}
    NR>1 {code[$6]++;}
    END { for(i in code) {printf("%d\t%d\t%f%%\n",i,code[i],100.0*code[i]/(NR-1));} }
    ' web_log.tsv
}
# 分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数
get_stateCode4 (){
    printf "%55s\t%s\n" "code=403 URL" "count"
    awk -F "\t" '
    NR>1 { if($6=="403") code[$5]++;}
    END { for(i in code) {printf("%55s\t%d\n",i,code[i]);} }
    ' web_log.tsv | sort -g -k 2 -r | head -10

    printf "%55s\t%s\n" "code=404 URL" "count"
    awk -F "\t" '
    NR>1 { if($6=="404") code[$5]++;}
    END { for(i in code) {printf("%55s\t%d\n",i,code[i]);;} }
    ' web_log.tsv | sort -g -k 2 -r | head -10
}
# 给定URL输出TOP 100访问来源主机
get_specificURL (){
    printf "%40s\t%s\n" "TOP100_host" "count"
    awk -F "\t" '
    NR>1 {if("'"$1"'"==$5) {host[$1]++;} }
    END { for(i in host) {printf("%40s\t%d\n",i,host[i]);} }
    ' web_log.tsv | sort -g -k 2 -r | head -100
}
while [ "$1" != "" ];do
    case "$1" in
       "-o")
      get_top100_host
      exit 0
      ;;
       "-p")
      get_top100_IP
      exit 0
      ;;
       "-u")
      get_top100_URL
      exit 0
      ;;
       "-c")
      get_stateCode
      exit 0
      ;; 
       "-f")
      get_stateCode4
      exit 0
      ;;
       "-s")
      get_specificURL "$2"
      exit 0
      ;;
       "-h")
      HELP
      exit 0
      ;;
    esac
done
get_top100_host
get_top100_IP
get_top100_URL
get_stateCode
get_stateCode4
get_specificURL /whats-new.html
HELP