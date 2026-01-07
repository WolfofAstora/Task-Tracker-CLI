#!/bin/bash
checkCreateJSON() {
	if ! [ -f ./todos.json ]; then
		echo -e "File does not exists\n Creating todos.json..."
		echo -e "[\n\n]" >> todos.json

	fi
}

addToJSON(){
	tmp=todos.tmp
	id=$(getID)
	local structure="	{
			\"id\" : $id,
			\"description\" : $1,
			\"status\" : \"todo\",
			\"createdAt\" : \"date\",
			\"updatedAt\" : \"date\"
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

getID(){
	oldID=$(grep -o -m 1 '[0-9]\+' todos.json)
	echo $((oldID + 1))
}

addTask(){	
	if [[ "$1" = 'add' && $# -eq 2 ]]; then
		echo "Task added sucessfully (ID: $(getID))"
		addToJSON $2
	fi
}

noParameter(){
	#TODO: not working, maybe replace with help if no arguments where given
	if [ $# -eq 0 ]; then
		echo "no parameters where given"
		exit 
	fi
}
main(){
	noParameter $#
	checkCreateJSON
	addTask $1 $2
	getID
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
