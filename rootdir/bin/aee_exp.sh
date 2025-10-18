#!/vendor/bin/sh
#
# Copyright (c) 2019, Motorola Mobility LLC,  All rights reserved.
#
# The purpose of this script is to annotate panic dumps with useful information
# about the context of the event.
#

export PATH=/vendor/bin:/system/bin:$PATH

build_type=`getprop ro.build.type`
expdb=`getprop vendor.debug.mtk.aeev.db`
aee_dir="/data/vendor/aee_exp"

echo "trigger_prop=$trigger_prop,trigger=$trigger,expdb=$expdb" >> /data/vendor/dontpanic/last_kmsg

if [ $build_type == "user" ] && [ -n "$expdb" ]; then
	kp_type=("KE" "HWT" "HW_Reboot" "ManualMRDump" "HANG")
	kp_found=0

	for file in $(ls $aee_dir); do
		for va in ${kp_type[@]}; do
			has_str=$(echo $file | grep "${va}")
			if [[ "$has_str" != "" ]]; then
				kp_found=1
				break
			fi
		done

		if [ $kp_found == 1 ]; then
			break
		fi
	done

	if [ $kp_found == 0 ]; then
		exit 0
	fi

	if [ ! -d /data/vendor/dontpanic/aee_exp ]
	then
		mkdir /data/vendor/dontpanic/aee_exp
	fi
	chmod -R 0750 /data/vendor/dontpanic/aee_exp/

	cp -RF /data/vendor/aee_exp/ /data/vendor/dontpanic/
	chown -R root:log /data/vendor/dontpanic/aee_exp/
	chmod -R 0750 /data/vendor/dontpanic/aee_exp/

	exit 0
fi
