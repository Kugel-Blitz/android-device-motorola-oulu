#!/vendor/bin/sh

PATH=/sbin:/vendor/sbin:/vendor/bin:/vendor/xbin
export PATH

scriptname=${0##*/}

debug()
{
	echo "$*"
}

clean_mbrain_folder()
{
	rm /data/vendor/mbrain/*_close
}

clean_mbrain_folder
