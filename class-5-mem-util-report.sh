#!/bin/bash
webhook_url="https://hooks.slack.com/services/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"
server=$(curl -sL http://169.254.169.254/latest/metadata/local-hostname)
total_mem=$(free -m | grep -i mem | awk -F " " '{print $2}')
avail_mem=$(free -m | grep -i mem | awk -F " " '{print $7}')
utilized_mem=$(echo "scale=0; ($total_mem - $avail_mem) * 100 / $total_mem" | bc)
if [ $utilized_mem -gt 80 ]; then
	echo "The current memory utilization is ${utilized_mem}%"
	curl -X POST -H "Content-Type: application/json" -d '{\"text\":\"⚠️Alert: For the following server ${server}, the current memory utilization is 
${utilized_mem}%. Kindly restart the server ${server}."}' $webhook_url
else
	echo "The current memory utilization is ${utilized_mem}%"
fi
