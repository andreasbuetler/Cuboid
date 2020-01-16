#include "arduino_secrets.h"


#include <SPI.h>
#include <WiFi101.h>
#include <MPU9250.h>

MPU9250 IMU(Wire, 0x68);
int SENSORstatus;

///////please enter your sensitive data in the Secret tab/arduino_secrets.h
char ssid[] = SECRET_SSID;        // your network SSID (name)
char pass[] = SECRET_PASS;    // your network password (use for WPA, or use as key for WEP)
int WIFIstatus = WL_IDLE_STATUS;     // the WiFi radio's status

WiFiServer server(80); // define server



void setup() {
  // serial to display data
  Serial.begin(115200);
  while (!Serial) {}

  // start communication with IMU
  SENSORstatus = IMU.begin();
  if (SENSORstatus < 0) {
    Serial.println("IMU initialization unsuccessful");
    Serial.println("Check IMU wiring or try cycling power");
    Serial.print("Status: ");
    Serial.println(SENSORstatus);
    while (1) {}
  }
  //---------------------------------------------
  // check for the presence of the shield:
  if (WiFi.status() == WL_NO_SHIELD) {
    Serial.println("WiFi shield not present");
    // don't continue:
    while (true);
  }
  // attempt to connect to WiFi network:
  while ( WIFIstatus != WL_CONNECTED) {
    Serial.print("Attempting to connect to WPA SSID: ");
    Serial.println(ssid);
    // Connect to WPA/WPA2 network:
    WIFIstatus = WiFi.begin(ssid, pass);

    // wait 10 seconds for connection:
    delay(500);
  }
  /* you're connected now, so print out the data: */
  server.begin();           /* start server at port 888 */
  Serial.print("You're connected to the network");
  printCurrentNet();

  printWiFiData();
  delay(5000);

}



void loop() {
  

  //int testVal = 0;
  WiFiClient client = server.available();
  if (client) {
    //    cs_4_8.set_CS_AutocaL_Millis(0xFFFFFFFF);
    Serial.println("new client connected !!!!!");
    //String currentLine = "";
    while (client.connected()) {
      IMU.readSensor();

      client.print(IMU.getAccelX_mss());
      client.print(",");  
      client.print(IMU.getAccelY_mss());
      client.print(",");
      client.print(IMU.getAccelZ_mss());
      
      client.print(",");

      client.print(IMU.getMagX_uT());
      client.print(",");  
      client.print(IMU.getMagY_uT());
      client.print(",");
      client.print(IMU.getMagZ_uT());

      client.print(",");

      client.print(IMU.getGyroX_rads());
      client.print(",");  
      client.print(IMU.getGyroY_rads());
      client.print(",");
      client.print(IMU.getGyroZ_rads());
      
      client.println("!");




      
      //      client.print(event.magnetic.x);
      //      client.print(",");
      //      client.print(event.magnetic.y);
      //      client.print(",");
      //      client.print(event.magnetic.z);
      //      client.print(",");
      //      client.print(totCS);
      ////      client.print(",");
      ////      client.print(anotherValue); // another value and so on...
      //      client.println("!");
      delay(50);
    }
  } else {
    //magnetometerRead();
    //    capacitiveRead();
  }
  client.stop();
  Serial.println("client disconnected");

  /* check the network connection information once every 500 miliseconds: */


  printCurrentNet();
  delay(500);


}


void printCurrentNet() {
  // print the SSID of the network you're attached to:
  Serial.print("SSID: ");
  Serial.println(WiFi.SSID());
  IPAddress ip = WiFi.localIP();
  Serial.print("IP Address: ");
  Serial.println(ip);
  // print the MAC address of the router you're attached to:
  byte bssid[6];
  WiFi.BSSID(bssid);
  Serial.print("BSSID: ");
  printMacAddress(bssid);

  // print the received signal strength:
  long rssi = WiFi.RSSI();
  Serial.print("signal strength (RSSI):");
  Serial.println(rssi);

  // print the encryption type:
  byte encryption = WiFi.encryptionType();
  Serial.print("Encryption Type:");
  Serial.println(encryption, HEX);
  Serial.println();
}

void printWiFiData() {
  // print your WiFi shield's IP address:
  IPAddress ip = WiFi.localIP();
  Serial.print("IP Address: ");
  Serial.println(ip);
  Serial.println(ip);

  // print your MAC address:
  byte mac[6];
  WiFi.macAddress(mac);
  Serial.print("MAC address: ");
  printMacAddress(mac);

}

void printMacAddress(byte mac[]) {
  for (int i = 5; i >= 0; i--) {
    if (mac[i] < 16) {
      Serial.print("0");
    }
    Serial.print(mac[i], HEX);
    if (i > 0) {
      Serial.print(":");
    }
  }
  Serial.println();
}
