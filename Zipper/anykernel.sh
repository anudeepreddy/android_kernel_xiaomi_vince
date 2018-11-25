# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Genom Kernel for MIUI ROMs
do.devicecheck=1
do.modules=1
do.cleanup=1
do.cleanuponabort=1
device.name1=vince
'; } # end properties

# shell variables
block=/dev/block/mmcblk0p21;
ramdisk_compression=auto;
is_slot_device=0;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chmod -R 755 $ramdisk/sbin;
chown -R root:root $ramdisk/*;


## AnyKernel install
dump_boot;

# begin ramdisk changes

# add default values 1
insert_line init.rc '# set default schedTune value for foreground/top-app (only affects EAS)' 'before' '# Mount staging areas for devices managed by vold' '# set default schedTune value for foreground/top-app (only affects EAS)'
insert_line init.rc 'write /dev/stune/foreground/schedtune.prefer_idle 1' 'after' '# set default schedTune value for foreground/top-app (only affects EAS)' 'write /dev/stune/foreground/schedtune.prefer_idle 1'
insert_line init.rc 'write /dev/stune/top-app/schedtune.prefer_idle 1' 'after' 'write /dev/stune/foreground/schedtune.prefer_idle 1' 'write /dev/stune/top-app/schedtune.prefer_idle 1'
insert_line init.rc 'write /dev/stune/top-app/schedtune.boost 7' 'after' 'write /dev/stune/top-app/schedtune.prefer_idle 1' 'write /dev/stune/top-app/schedtune.boost 10'

# add default values 2
insert_line init.rc '# update cpusets now that processors are up' 'before' '# Start standard binderized HAL daemons' '# update cpusets now that processors are up'
insert_line init.rc 'write /dev/stune/foreground/schedtune.prefer_idle 1' 'after' '# update cpusets now that processors are up' 'write /dev/stune/foreground/schedtune.prefer_idle 1'
insert_line init.rc 'write /dev/stune/top-app/schedtune.prefer_idle 1' 'after' 'write /dev/stune/foreground/schedtune.prefer_idle 1' 'write /dev/stune/top-app/schedtune.prefer_idle 1'
insert_line init.rc 'write /dev/stune/top-app/schedtune.boost 1' 'after' 'write /dev/stune/top-app/schedtune.prefer_idle 1' 'write /dev/stune/top-app/schedtune.boost 1'

# make schedutil default governor
insert_line init.rc '# set governor' 'before' '# scheduler tunables' '# set governor'
insert_line init.rc 'write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor "schedutil"' 'after' '# set governor' 'write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor "schedutil"'

# end ramdisk changes

write_boot;

## end install

