#/system/bin/sh
echo "test1" > /dev/testing
sleep 30
ifconfig wlan0 up
echo "test2" >> /dev/testing
