#!/bin/bash
checkCreateJSON() {
	if ! [ -f ./todos.json ]; then
		echo -e "File does not exists\n Creating todos.json..."
		echo -e "[\n\n]" >> todos.json

	fi
}

addToJSON(){
	local tmp=todos.tmp
	local now=`date`
	local id=$(getID)
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
	if [[ $gatheredID = "$2" && "$#" -eq 3 ]]; then
		updateBlock $gatheredID description "$3"
		updateBlock $gatheredID updatedAt "`date`"

	else 
		echo This ID: "$2" was not found in 'todos.json'
		echo Or no description was given
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
updateBlock(){
	local ID=$1
	local keyWord=$2
	local value=$3

	sed -z -E -i 's/("id".*'"$ID"',[^}]*"'"$keyWord"'"\s*:\s*")[^"]*"/\1'"$value"'"/' todos.json
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
