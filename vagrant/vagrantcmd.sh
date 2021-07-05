set -e

DEFAULT_ROOT="../.vboxmachines"
DEFAULT_FOLDER=0
COMMAND=0

if [ $# -lt  1 ]; then
	echo "Error: need vagrant folder and command, or just command"
	exit 1
fi

if [ $# -ne 2 ]; then
	while true; do
		read -p "WARNING: no folder given, using $DEFAULT_ROOT. Continue? " yn
		case $yn in
			[Yy]* ) break;;
			[Nn]* ) exit 0; break;;
			* ) echo "Please answer y/n.";;
		esac
	done
	DEFAULT_FOLDER=$(pwd)/$DEFAULT_ROOT
	COMMAND=$1
else
	DEFAULT_FOLDER=$1
	COMMAND=$2
	echo "INFO: Using ${DEFAULT_FOLDER} as root."
fi

OLD_HOME=$VAGRANT_HOME
export VAGRANT_HOME=$DEFAULT_FOLDER/vagrant.d

VBoxManage setproperty machinefolder $DEFAULT_FOLDER
vagrant $COMMAND
VBoxManage setproperty machinefolder default

export VAGRANT_HOME=$OLD_HOME

exit 0
