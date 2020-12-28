#!/bin/bash

check_container() {
	result="$( docker container inspect -f '{{.State.Running}}' $1 )"
	[[ $result = true ]] && result=0 || result=1
	return $result
}

start_container() {
	check_container $1
	if [[ "$?" -eq 0 ]]; then
        	echo "$1 is running already..."
	else
        	docker start $1
	        echo "$1 started..."
	fi	
}

start_container coffeeshopdb
check_container coffeeshopdb
count=0
while [[ "$?" -ne 0 && "$count++" -lt 5  ]]; do
	echo "Waiting coffeeshopdb to start..."
	sleep 5s
	check_container coffeeshopdb
done
start_container coffeeshopservices
start_container coffeeshopweb
