#!/vendor/bin/sh

PATH=/sbin:/vendor/sbin:/vendor/bin:/vendor/xbin
export PATH

scriptname=${0##*/}

notice()
{
	echo "$*"
	echo "$scriptname: $*" > /dev/kmsg
}

csr_type_prop=$(getprop vendor.tcmd.extract.csr_type)

if [[ $csr_type_prop == "tee_keymint" ]] || [[ $csr_type_prop == "strongbox_keymint" ]] || [[ $csr_type_prop == "widevine" ]]; then
	notice "Extracted CSR type: $csr_type_prop"
	/vendor/bin/rkp_factory_extraction_tool64 --$csr_type_prop --output_format "build+csr" > /mnt/vendor/mot_factory/csr.json
else
	notice "Invalid CSR type: $csr_type_prop"
	exit 0
fi

# In case tcmd is blocked by the umask, change it to be globally readable.
if [ -f /mnt/vendor/mot_factory/csr.json ];then
	chmod 0644 /mnt/vendor/mot_factory/csr.json
fi
