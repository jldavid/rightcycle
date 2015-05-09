* https://software.intel.com/en-us/articles/getting-started-with-the-intel-edison-board-on-os-x#terminal
* ls /dev/cu.usbserial-*
  * /dev/cu.usbserial-DA00ZEPW
* screen /dev/cu.usbserial-DA00ZEPW 115200 –L
* edison login: root
* configure_edison --setup
 * Password: 123456789
 * Device name: edison
 * Setup wifi
 * ping google.com
