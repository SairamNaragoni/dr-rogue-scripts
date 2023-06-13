#! /bin/bash

function re(){
	while read -r f ; do source "$f" ; done < <(find $SCRIPTS_PATH -wholename '*.conf')
	while read -r f ; do source "$f" ; done < <(find $SCRIPTS_PATH -wholename '*.sh')
}

re