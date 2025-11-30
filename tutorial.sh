#!/bin/bash

checkCreateJSON() {
	if ! [ -f ./todos.json ]; then
		echo -e "File does not exists\n Creating todos.json..."
		touch todos.json
	fi
}


if [ $# -eq 0 ]; then
	echo "no parameters where given"
fi



if [ "$1" = 'add' ]; then
	checkCreateJSON
	echo "add has been typed wuhu"
	if [ $# -eq 2 ]; then
		echo "$2 will be added to your todo list heheha"
		
	else
		echo "add needs a task to be added to your todo list"
	fi
fi

