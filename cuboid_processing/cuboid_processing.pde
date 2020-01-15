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
  myRemoteLocation = new NetAddress("127.0.0.1",8000);
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
  //println(" X= "+magX+" Y= "+magY+" Z= "+magZ);
  //println(" aX= "+accelX+" aY= "+accelY+" aZ= "+accelZ);
  //println( " calibrated Z : " + resetAccZ);
  
  background(0);
  pushMatrix();
  translate(width/2, height/2);
  //rotateX(radians(map(magX,-2,2,0,360)));
  //rotateY(radians(map(magY,-2,2,0,360)));
  rotateZ(radians(map(magZ, -10, 10, 0, 180)));
  stroke(0);
  strokeWeight(1);
  fill(255);
  box(200);
  popMatrix();
  int multiplicator = 100;
  stroke(255, 0, 0);
  strokeWeight(5);
  fill(255, 0, 0);
  noStroke();
  rect(width/2, 20, (accelZ-resetAccZ)*100, 10);
  calibration();
  directionRotZ();
  oscHandler();
}

int calibrationCount=0;
float resetAccZ;
boolean calibratedFlag=false;
void calibration() {
  if (calibrationCount<60) {
    calibrationCount++;
  } else {
    if (!calibratedFlag) {

      resetAccZ=accelZ;
      calibratedFlag=true;
    }
  }
}
float actualAccZ;
String directionZ="";
void directionRotZ(){
  actualAccZ = accelZ-resetAccZ;
  if(actualAccZ <0 ){
  directionZ ="Left";
  }else{
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
            magX=float(list[0]); // magnetometer.x
            magY=float(list[1]); // magnetometer.y
            magZ=float(list[2]); // magnetometer.z

            accelX=float(list[3]); // accel.x
            accelY=float(list[4]); // accel.y
            accelZ=float(list[5]); // accel.z
            //valF[3]=float(list[3]); // cap sensing value
            // valF[4]=float(list[4]); ... and so on
          }
        }
      }
    }
  }
}

  void oscHandler(){
      OscMessage myMessage = new OscMessage("/magX");
  
  myMessage.add(magX); /* add an int to the osc message */

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation);
  
  }
