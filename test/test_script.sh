#!/bin/sh
set -u
set -o errexit

someFunction() {
    endTime=$(( $(date +%s) + userTimeout ))
    for component in foo bar
    do
        echo "checking $component in $environment"
    done
}

# gitDiff() {
#     changedFile=$(git diff --name-only index.html fanews.css)
#     if [ "$changedFile" = "index.html"
# }

help() {
	# display help
	echo "Run a test script with some fake options"
	echo
	echo "Syntax ./test_script.sh [-h] environment [dev|test] timeout (seconds)"
	echo "environment has two options, 'dev' or 'test'"
	echo "options:"
	echo "h		print this help"
	echo
}

while getopts ":h" option; do
	case $option in
		h) #display help
			help
			exit;;
		# t) # change the timeout
		# 	userTimeout=$OPTARG;;
		# 	setTimeout($userTimeout)
		\?) #invalid option
			echo "Error: Invalid option"
		 	exit;;
	esac
done

environment=$1
userTimeout=$2
someFunction