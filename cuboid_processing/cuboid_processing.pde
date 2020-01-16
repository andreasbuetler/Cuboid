import processing.net.*;  
import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress myRemoteLocation;

Client myClient; 
String dataIn="";
byte [] byteBuffer = new byte[64];
byte interesting = byte('!');
float [] valF;




boolean clientConnected = false;

void setup() {
  //size(600, 640,FX2D); 
  //frameRate(120);
  size(500, 500);
  //smooth();

  myRemoteLocation = new NetAddress("127.0.0.1", 8000);
  myClient = new Client(this, "192.168.1.77", 80);
  oscP5 = new OscP5(this, 12000);

  if (!clientConnected) {
    clientConnected=true;
  }
  valF = new float[5];
  for (int i = 0; i < valF.length; i++) {
    valF[i]=0.0;
  }
}

void draw() {
  readClient();

  getCalibratedValues();
  //printAllValues();
  //visualization();
  batteryLevel();
  //gyroVisualization();
  MovementDetection();
  //calibration();

  //directionRotZ();
  oscHandler();
  delay(50);
}
