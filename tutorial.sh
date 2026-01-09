#!/bin/bash
checkCreateJSON() {
	if ! [ -f ./todos.json ]; then
		echo -e "File does not exists\n Creating todos.json..."
		echo -e "[\n\n]" >> todos.json

	fi
}

addToJSON(){
	tmp=todos.tmp
	now=`date`
	id=$(getID)
	local structure="	{
			\"id\" : $id,
			\"description\" : \"$1\",
			\"status\" : \"todo\",
			\"createdAt\" : \"$now\",
			\"updatedAt\" : \"$now\"
	},"
	awk -v txt="$structure" '
	$0 == "[" {
		print
		print txt
		next
	}
	{
	print
	}' todos.json > "$tmp" && mv "$tmp" todos.json
}
updateJSON(){
	gatheredID=$(checkID "$@")
	if [[ $gatheredID = "$2" ]]; then
		echo $gatheredID
	else 
		echo This ID: "$2" was not found in 'todos.json'
		exit 1
	fi
}

checkID(){
	id=$(grep -o -m 1 "${2}\+" todos.json)
	echo $id
}

getID(){
	oldID=$(grep -o -m 1 '[0-9]\+' todos.json)
	echo $((oldID + 1))
}

addTask(){	
	echo "Task added sucessfully (ID: $(getID))"
	addToJSON "$2"
}

noParameter(){
	echo -e "Wrong parameter given\n"
	echo use add \"description\" to create new tasks
	echo use update '<TASK_ID>' to update existing tasks
}

main(){
	checkCreateJSON
	case $1 in
		add)
			addTask "$@"
			;;
		update)
			updateJSON "$@"
			;;
		*)
			noParameter
			;;
	esac
}

main "$@"




# [
#   {
#      "id" : 1,
#      "description" : "djalsdfjas",
#      "status" : "todo",
#      "createdAt" : "12.12.12",
#      "updatedAt" : "13.12.12"
#   },
#   ...
# ]
