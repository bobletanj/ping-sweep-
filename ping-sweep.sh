  #list living hosts (responding to ping) on a /24 subnet
#each ping in a subprocess
subnet=192.168.1


echo "list living hosts (responding to ping) on a /24 subnet"
for i in {1..254}; do 
	(
		if ping -c 1 -W 1 $subnet.$i &> /dev/null; then
			mac_address=$(arp -an $subnet.$i | grep -o -E '[0-9a-f]{2}:[0-9a-f]{2}:[0-9a-f]{2}:[0-9a-f]{2}:[0-9a-f]{2}:[0-9a-f]{2}')
			# alternative regex: ([0-9a-f]{2}:?){6} 
			echo "$subnet.$i    $mac_address"
		fi 
	)  &
done | sort
wait 
