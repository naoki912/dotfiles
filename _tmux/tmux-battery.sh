# http://polamjag.hatenablog.jp/entry/2013/10/23/125843

if [ `acpi -b | grep -oE Discharging` = "Discharging" ] ; then

    if [ `acpi -b | grep -oE \[0-9\]+%` -lt 10 ] ; then
        echo -n \#\[fg=yellow,bold\]
        echo "batteryyyyyy `acpi -b | grep -oE \[0-9\]+%`"
    else
        echo -n \#\[fg=green,bold\]
        echo "no charging `acpi -b | grep -oE \[0-9\]+%`"
    fi

else
    echo `acpi -b | grep -oE \[0-9\]+%`
fi
