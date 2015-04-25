
if cat /proc/device-tree/model | grep "TS-TPC-8950"; then
	wm density 120
elif cat /proc/device-tree/model | grep "TS-TPC-8390"; then
	wm density 128
fi
