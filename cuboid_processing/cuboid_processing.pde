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

int state = 0;

int batteryLevel = 0;

float TmagX;
float TmagY;
float TmagZ;

float TaccelX;
float TaccelY;
float TaccelZ;

float magX;
float magY;
float magZ;

float accelX;
float accelY;
float accelZ;

boolean clientConnected = false;

void setup() {
  //size(600, 640,FX2D); 
  //frameRate(120);
  size(500, 500, P3D);
  smooth();
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
  calibration();
  getCalibratedValues();
  directionRotZ();
  oscHandler();
  
  if(state==0){
    noMovement();
  }
  if(state==0){
    pickedUp();
  }
  if(state==0){
  }
  if(state==0){
  }
  Drawing();
  delay(10);
}

int calibrationCount=0;

float resetAccX;
float resetAccY;
float resetAccZ;
float resetMagX;
float resetMagY;
float resetMagZ;
boolean calibratedFlag=false;
void calibration() {
  if (calibrationCount<60) {
    calibrationCount++;
  } else {
    if (!calibratedFlag) {

      resetAccX=accelX;
      resetAccY=accelY;
      resetAccZ=accelZ;
      resetMagX=magX;
      resetMagY=magY;
      resetMagZ=magZ;

      calibratedFlag=true;
    }
  }
}
float actualAccZ;
String directionZ="";
void directionRotZ() {
  actualAccZ = accelZ-resetAccZ;
  if (actualAccZ <0 ) {
    directionZ ="Left";
  } else {
    directionZ="right";
  }
  println(directionZ);
}

String values="";
void readClient() {

  if (clientConnected) {
    if (myClient.available()>0) { 
      // Read until we get a linefeed
      int byteCount = myClient.readBytesUntil(interesting, byteBuffer); 
      // Convert the byte array to a String
      String myString = new String(byteBuffer);
      values = trim(myString);
      // Display the string

      String[] list = split(values, ',');
      // valF = new float[list.length];
      // float [] valu
      if (list.length>0) {
        for (int i=0; i < list.length; i ++) {
          list[i]=list[i].replaceAll("!", "");
          if (list.length==6) {
            TmagX=float(list[0]); // magnetometer.x
            TmagY=float(list[1]); // magnetometer.y
            TmagZ=float(list[2]); // magnetometer.z

            TaccelX=float(list[3]); // accel.x
            TaccelY=float(list[4]); // accel.y
            TaccelZ=float(list[5]); // accel.z
            //valF[3]=float(list[3]); // cap sensing value
            // valF[4]=float(list[4]); ... and so on
          }
        }
      }
    }
  }
}

void oscHandler() {
  OscMessage value1 = new OscMessage("/value1");
  OscMessage value2 = new OscMessage("/value2");
  OscMessage value3 = new OscMessage("/value3");
  OscMessage value4 = new OscMessage("/value4");

  value1.add(magX); /* add an int to the osc message */
  value2.add(magX);
  value3.add(magX);
  value4.add(magX);

  /* send the message */
  oscP5.send(value1, myRemoteLocation);
  oscP5.send(value2, myRemoteLocation);
  oscP5.send(value3, myRemoteLocation);
  oscP5.send(value4, myRemoteLocation);
}

void getCalibratedValues() {
  magX = TmagX - resetMagX;
  magY = TmagY - resetMagY;
  magZ = TmagZ - resetMagZ;

  accelX = TaccelX - resetAccX;
  accelY = TaccelY - resetAccX;
  accelZ = TaccelZ - resetAccZ;
}

void Drawing(){
   background(0);
  pushMatrix();
  translate(width/2, height/2);
  pushMatrix();
  //rotateZ(radians(map(magZ, -10, 10, 0, 180)));
  //rotateX(radians(map(magX, -10, 10, 0, 180)));
  //rotateY(radians(map(magY, 10, -10, 0, 180)));
  stroke(255);
  strokeWeight(1);
  //fill(255);
  noFill();
  box(200);
  popMatrix();
  stroke(255, 0, 0);
  strokeWeight(5);
  line(0, 0, 0, accelX*100, accelY*100, accelZ*100);
  popMatrix();
  stroke(255, 0, 0);
  strokeWeight(5);
  fill(255, 0, 0);
  noStroke();
  rect(width/2, 20, accelZ*100, 10);

  
}
