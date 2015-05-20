cat /proc/device-tree/model | grep "TS-TPC-8950"
if [ $? -eq 0 ]; then
        wm density 120
fi

cat /proc/device-tree/model | grep "TS-TPC-8390"
if [ $? -eq 0 ]; then
        wm density 128
fi

cat /proc/device-tree/model | grep "TS-TPC-8395"
if [ $? -eq 0 ]; then
	wm density 170
fi

