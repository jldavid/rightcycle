* https://software.intel.com/en-us/articles/getting-started-with-the-intel-edison-board-on-os-x#terminal
* ls /dev/cu.usbserial-*
  * /dev/cu.usbserial-DA00ZEPW
* screen /dev/cu.usbserial-DA00ZEPW 115200 –L
* edison login: root
* configure_edison --setup
 * Password: 12345678
 * Device name: edison
 * Setup wifi
 * ping google.com
* Setup server
 * npm install express
 * express app in app.js + https://github.com/intel-iot-devkit/mraa/blob/master/examples/javascript/GPIO_DigitalWrite.js
 * node app.js
 * ? https://github.com/ajfisher/node-pixel
