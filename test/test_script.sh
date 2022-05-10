#!/bin/sh
set -u
set -o errexit

# invoke a script that uses kubectl to query the 'up-to-date' and 'ready' counters for the api and integrations deployments for QA and UAT, waiting for it to be ready.  Fail after 5ish minutes

checkEnvironment(){
# check if specific files have been updated.  to add to this list simply update the for loop with a new value.
	for environment in qa uat
	do
		changedFile=$(git diff ..origin/master --name-only test-$environment.yaml)
		if [ -n "$changedFile" ]; then
			echo "Checking $environment components (test/test-$environment.yaml updated)"
			validateDeployment "$environment"
		else
			echo "$environment helmfile not updated, not checking components as they will not be restarted"
		fi
	done
}

validateDeployment() {
# compare the ready pods against the requested number of replicas.  If they do not match by the requested timeout, or if none are requested fail.
	environment=$1
	endTime=$(( $(date +%s) + userTimeout ))
	for component in api integrations
	do
		echo "checking $component"
		readyCount=1
		replicaCount=1
		# readyCount=$(kubectl -n $environment get deployment -l component=$component,app=axiom -o jsonpath='{.items[*].status.readyReplicas}')
		# replicaCount=$(kubectl -n $environment get deployment -l component=$component,app=axiom -o jsonpath='{.items[*].status.replicas}')
		if [ -z "$replicaCount" ]; then
			echo "no replicas requested, this seems wrong.  Exiting"
			exit 1;
		else
			echo "Ready/Replicas"
			while [ "$readyCount" != "$replicaCount" ]; do
				if [ "$readyCount" != "$replicaCount" ] && [ $(date +%s) -lt $endTime ]; then
					echo "$readyCount/$replicaCount"
					sleep 10
					readyCount=$(kubectl -n $environment get deployment -l component=$component,app=axiom -o jsonpath='{.items[*].status.readyReplicas}')
					replicaCount=$(kubectl -n $environment get deployment -l component=$component,app=axiom -o jsonpath='{.items[*].status.replicas}')
				elif [ "$readyCount" != "$replicaCount" ] && [ $(date +%s) -gt $endTime ]; then
					echo "pods did not become ready.  Exiting"
					exit 1;
				fi
			done
		fi
		echo "$readyCount/$replicaCount"
		echo "deployments up to date"
	done
}

help() {
	echo "Wait for the deployments to become Ready"
	echo
	echo "Syntax ./wait-for-up-to-date.sh [-h] timeout (seconds)"
	echo "options:"
	echo "h		print this help"
	echo
}

while getopts ":h" option; do
	case $option in
		h) #display help
			help
			exit;;
		\?) #invalid option
			echo "Error: Invalid option"
		 	exit;;
	esac
done

userTimeout=$1
checkEnvironment