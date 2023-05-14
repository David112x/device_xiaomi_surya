#!/vendor/bin/sh

# Set platform variables
soc_hwplatform=`cat /sys/devices/soc0/hw_platform 2> /dev/null`
soc_machine=`cat /sys/devices/soc0/machine 2> /dev/null`
soc_machine=${soc_machine:0:2}
soc_id=`cat /sys/devices/soc0/soc_id 2> /dev/null`
#
# Check ESOC for external modem
#
# Note: currently only a single MDM/SDX is supported
#
esoc_name=`cat /sys/bus/esoc/devices/esoc0/esoc_name 2> /dev/null`
target=`getprop ro.board.platform`

# Chip-serial is used for unique MSM identification in Product string
msm_serial=`cat /sys/devices/soc0/serial_number`;
# If MSM serial number is not available, then keep it blank instead of 0x00000000
if [ "$msm_serial" != "" ]; then
	msm_serial_hex=`printf %08X $msm_serial`
fi
	machine_type=`cat /sys/devices/soc0/machine`
	setprop vendor.usb.product_string "$machine_type-$soc_hwplatform _SN:$msm_serial_hex"
	echo $msm_serial_hex > /config/usb_gadget/g1/functions/diag.diag/serial
