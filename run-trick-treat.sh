#!/bin/bash
cat << "EOF" 
 ______    _     __                ______             __ 
/_  __/___(_)___/ /__  ___  ____  /_  __/______ ___ _/ /_
 / / / __/ / __/  '_/ / _ \/ __/   / / / __/ -_) _ `/ __/
/_/ /_/ /_/\__/_/\_\  \___/_/     /_/ /_/  \__/\_,_/\__/ 

                                 v.1 Penyihir.exe - BGZ
EOF


printf "Please wait, Checking domain with HTTPX\n"
$(cat file_domain.txt | httpx -l file_domain.txt --follow-redirects --silent >> result_file_domain.txt)
wait -n
	echo -e "\e[1;31m[+] Checking Complete\e[0m"
printf "Please wait, Fecthing domain with Waybackurl\n"
$(cat result_file_domain.txt | waybackurls > waybackurls.txt)
wait -n
	echo -e "\e[1;31m[+] Fecthing Complete\e[0m"
printf "Please wait, Gauplus is running\n"
$(cat result_file_domain.txt | gauplus -o result.txt --random-agent -t 40)
wait -n
	echo -e "\e[1;31m[+] Gauplus Complete\e[0m"
printf "Please wait, Replacing text\n"
$(sed -i "s/^http.*\/$//" result.txt)
wait -n
	echo -e "\e[1;31m[+] Replacing Text Complete\e[0m"
printf "Please wait, Replacing Extension\n"
$(grep -vE "robots.txt$|robots.txt\/$|.jpg|.jpeg|.gif|.css|.tif|.tiff|.png|.ttf|.woff|.woff2|.ico|.pdf|.svg|.txt|.js|.xml|.xls|.word" result.txt > clean_result.txt)
wait -n
	echo -e "\e[1;31m[+] Replacing Extension Complete\e[0m"
printf "Please wait, Sorting URL\n"
$(sort -u clean_result.txt > sort_clean_result.txt)
wait -n
	echo -e "\e[1;31m[+] Sorting URL Complete\e[0m"
printf "Please wait, Combining URL\n"
$(cat sort_clean_result.txt | unew -combine > tmp_result.txt)
wait -n
	echo -e "\e[1;31m[+] Combine URL Complete\e[0m"
printf "Please wait, Searching "?" in List\n"
$(cat tmp_result.txt | grep -a "?" > final_result.txt)
wait -n
	echo -e "\e[1;31m[+] Searching "?" in list complete\e[0m"
printf "Please wait, Getting final list with WURL\n"
$(cat final_result.txt | wurl -c 500 -s 200 -o waybackurls.txt)
wait -n
	echo -e "\e[1;31m[+] List created\e[0m"
printf "Deleting OLD file\n"
$(rm -rf result.txt clean_result.txt sort_clean_result.txt tmp_result.txt final_result.txt)
wait -n
	echo -e "\e[1;31m[+] Successfull delete\e[0m"
printf "Finding Unique Keys\n"
$(cat waybackurls.txt | sort -u | unfurl --unique keys > paramlist.txt)
wait -n
	echo -e "\e[1;31m[+] Complete Collecting Unique Keys\e[0m"
printf "Finding JS\n"
$(cat waybackurls.txt | sort -u | grep -P "\w+\.js(\?|$)" | sort -u > jsurl.txt)
wait -n
	echo -e "\e[1;31m[+] Complete Collecting JS\e[0m"
printf "Finding PHP\n"
$(cat waybackurls.txt | sort -u | grep -P "\w+\.php(\?|$)" | sort -u > phpurl.txt)
wait -n
	echo -e "\e[1;31m[+] Complete Collecting PHP\e[0m"
printf "Finding ASPX\n"
$(cat waybackurls.txt | sort -u | grep -P "\w+\.aspx(\?|$)" | sort -u > aspxurl.txt)
wait -n
	echo -e "\e[1;31m[+] Complete Collecting ASPX\e[0m"
printf "Finding JSP\n"
$(cat waybackurls.txt | sort -u | grep -P "\w+\.jsp(\?|$)" | sort -u > jspurl.txt)
wait -n
	echo -e "\e[1;31m[+] Complete Collecting JSP\e[0m"
printf "Finding OPEN URL\n"
$(cat waybackurls.txt | sort -u | grep url= > open_url.txt)
wait -n
	echo -e "\e[1;31m[+] Complete Collecting OPEN URL\e[0m"
printf "Finding OPEN Redirect With Grep\n"
$(cat waybackurls.txt | sort -u | grep redirect= > open_redirect.txt)
wait -n
	echo -e "\e[1;31m[+] Complete Collecting OPEN URL\e[0m"
# Running GF-Pattern
printf "Running for XSS\n"
$(gf xss waybackurls.txt > xss_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting XSS\e[0m"

printf "Running for AWS_Keys\n"
$(gf aws-keys waybackurls.txt > aws_keys_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting AWS Keys\e[0m"

printf "Running for CORS\n"
$(gf cors waybackurls.txt > cors_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting CORS\e[0m"

printf "Running for DebugPages\n"
$(gf debug-pages waybackurls.txt > debug_pages_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting DebugPages\e[0m"

printf "Running for Debug_Logic\n"
$(gf debug_logic waybackurls.txt > debug_logic_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting DebugLogic\e[0m"

printf "Running for Firebase\n"
$(gf firebase waybackurls.txt > firebase_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting Firebase\e[0m"

printf "Running for FW\n"
$(gf fw waybackurls.txt > fw_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting FW\e[0m"

printf "Running for Go_Function\n"
$(gf go-functions waybackurls.txt > go_functions_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting GoFunction\e[0m"

printf "Running for HTTP_Auth\n"
$(gf http-auth waybackurls.txt > http_auth_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting HTTP Auth\e[0m"

printf "Running for IDOR\n"
$(gf idor waybackurls.txt > idor_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting IDOR\e[0m"

printf "Running for IMG_Transversal\n"
$(gf img-traversal waybackurls.txt > img_traversal_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting ImgTransversal\e[0m"

printf "Running for Interesting_EXT\n"
$(gf interestingEXT waybackurls.txt > interestingEXT_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting InterestingEXT\e[0m"

printf "Running for Intersting_Params\n"
$(gf interestingparams waybackurls.txt > interestingparams_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting InterestingParams\e[0m"

printf "Running for Interesting_Subs\n"
$(gf interestingsubs waybackurls.txt > interestingsubs_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting InterestingSubs\e[0m"

printf "Running for IP\n"
$(gf ip waybackurls.txt > ip_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting IP\e[0m"

printf "Running for JSON_Sec\n"
$(gf json-sec waybackurls.txt > json_sec_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting JSONsec\e[0m"

printf "Running for JSvar\n"
$(gf jsvar waybackurls.txt > jsvar_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting JSvar\e[0m"

printf "Running for LFI\n"
$(gf lfi waybackurls.txt > lfi_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting LFI\e[0m"

printf "Running for PHP_Curl\n"
$(gf php-curl waybackurls.txt > php_curl_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting PHP-Curl\e[0m"

printf "Running for PHP_Error\n"
$(gf php-errors waybackurls.txt > php_errors_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting PHP-Error\e[0m"

printf "Running for PHP_Serialized\n"
$(gf php-serialized waybackurls.txt > php_serialized_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting Serialized\e[0m"

printf "Running for PHP_Sinks\n"
$(gf php-sinks waybackurls.txt > php_sinks_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting PHP-Sinks\e[0m"

printf "Running for PHP_Source\n"
$(gf php-sources waybackurls.txt > php_sources_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting PHP-Source\e[0m"

printf "Running for RCE\n"
$(gf rce waybackurls.txt > rce_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting RCE\e[0m"

printf "Running for Redirect\n"
$(gf redirect waybackurls.txt > redirect_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting Redirect\e[0m"

printf "Running for S3_Buckets\n"
$(gf s3-buckets waybackurls.txt > s3_buckets_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting S3-Buckets\e[0m"

printf "Running for SEC\n"
$(gf sec waybackurls.txt > sec_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting SEC\e[0m"

printf "Running for Servers\n"
$(gf servers waybackurls.txt > servers_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting Servers\e[0m"

printf "Running for SQLI\n"
$(gf sqli waybackurls.txt > sqli_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting SQLI\e[0m"

printf "Running for SSRF\n"
$(gf ssrf waybackurls.txt > ssrf_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting SSRF\e[0m"

printf "Running for SSTI\n"
$(gf ssti waybackurls.txt > ssti_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting SSTI\e[0m"

printf "Running for Strings\n"
$(gf strings waybackurls.txt > strings_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting Strings\e[0m"

printf "Running for TakeOver\n"
$(gf takeovers waybackurls.txt > takeovers_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting TakeOver\e[0m"

printf "Running for UploadFile\n"
$(gf upload-fields waybackurls.txt > upload_fields_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting Uploadfile\e[0m"

printf "Running for URLS\n"
$(gf urls waybackurls.txt > urls_result.txt)
wait
echo -e "\e[0;32m[+] Complete Collecting URLs\e[0m"

printf "[Semua kami retas - BGZ]\n"
