#!/bin/bash

start_container() {
	DB_STAT="$( docker container inspect -f '{{.State.Running}}' $1 )"
	if [[ "$DB_STAT" ]]; then
        	 echo "$1 is running already..."
	else
        	docker start coffeeshopdb
	        echo "$1 started..."
	fi	

}

start_container "coffeeshopdb"
start_container "coffeeshopservices"
