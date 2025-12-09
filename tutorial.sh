#!/bin/bash
checkCreateJSON() {
	if ! [ -f ./todos.json ]; then
		echo -e "File does not exists\n Creating todos.json..."
		echo -e "[\n\n]" >> todos.json

	fi
}

getJSONContent(){
	local data=(cat todos.json)
	echo $data
}

addToJSON(){	

	structure="{
			\"id\" : 1,\n
			\"description\" : $2,\n
			\"status\" : \"todo\",\n
			\"createdAt\" : \"date\",\n
			\"updatedAt\" : \"date\"\n
		   }"
	echo $structure >> todos.json

}

addTask(){	
	if [[ "$1" = 'add' && $# -eq 2 ]]; then
		echo "$2 will be added to your todo list"
		getJSONContent #debug
		# addToJSON $2
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
