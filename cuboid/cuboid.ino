#include "arduino_secrets.h"


#include <SPI.h>
#include <WiFi101.h>
#include <MPU9250.h>

MPU9250 IMU(Wire,0x68);
int status;



void setup() {
  // serial to display data
  Serial.begin(115200);
  while(!Serial) {}

  // start communication with IMU 
  status = IMU.begin();
  if (status < 0) {
    Serial.println("IMU initialization unsuccessful");
    Serial.println("Check IMU wiring or try cycling power");
    Serial.print("Status: ");
    Serial.println(status);
    while(1) {}
  }
}



void loop() {
  IMU.readSensor();



    delay(100); //check with WIFI communication
}
