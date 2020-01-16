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

float batteryLevel = 0;

float TmagX;
float TmagY;
float TmagZ;

float TaccelX;
float TaccelY;
float TaccelZ;

float TgyroX;
float TgyroY;
float TgyroZ;

float magX;
float magY;
float magZ;

float accelX;
float accelY;
float accelZ;

float gyroX;
float gyroY;
float gyroZ;

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
  getCalibratedValues();
  //printAllValues();
  //visualization();
  batteryLevel();
  gyroVisualization();

  calibration();
  
  directionRotZ();
  oscHandler();
  delay(10);
}

int calibrationCount=0;

float resetAccX;
float resetAccY;
float resetAccZ;
float resetMagX;
float resetMagY;
float resetMagZ;
float resetGyroX;
float resetGyroY;
float resetGyroZ;
boolean calibratedFlag=false;
void calibration() {
  if (calibrationCount<60) {
    calibrationCount++;
  } else {
    if (!calibratedFlag) {
      
      resetAccX=TaccelX;
      resetAccY=TaccelY;
      resetAccZ=TaccelZ;
      resetMagX=TmagX;
      resetMagY=TmagY;
      resetMagZ=TmagZ;
      resetGyroX=TgyroX;
      resetGyroY=TgyroY;
      resetGyroZ=TgyroZ;

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
  //println(directionZ);
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
          if (list.length==9) {
            

            TmagX=float(list[3]); // magnetometer.x
            TmagY=float(list[4]); // magnetometer.y
            TmagZ=float(list[5]); // magnetometer.z

            TgyroX=float(list[0]); // gyro.x
            TgyroY=float(list[1]); // gyro.y
            TgyroZ=float(list[2]); // gyro.z

            TaccelX=float(list[6]); // accel.x
            TaccelY=float(list[7]); // accel.y
            TaccelZ=float(list[8]); // accel.z
            
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
  
   void getCalibratedValues(){
       magX = TmagX - resetMagX;
       magY = TmagY - resetMagY;
       magZ = TmagZ - resetMagZ;
       
       accelX = TaccelX - resetAccX;
       accelY = TaccelY - resetAccY;
       accelZ = TaccelZ - resetAccZ;
       
       gyroX = TgyroX - resetGyroX;
       gyroY = TgyroY - resetGyroY;
       gyroZ = TgyroZ - resetGyroZ;
   }
   
   void printAllValues(){
     println("Magnetometer: "+"\t"+"X = "+TmagX+"\t"+"Y = "+TmagY+"\t"+"Z = "+TmagZ);
     println("Acceleration: "+"\t"+"X = "+TaccelX+"\t"+"Y = "+TaccelY+"\t"+"Z = "+TaccelZ);
     println("Gyro: "+"\t\t"+"X = "+TgyroX+"\t"+"Y = "+TgyroY+"\t"+"Z = "+TgyroZ);
   
   }
   
   void batteryLevel(){
     float decreaseValue = 1;
     float accelerationValue = abs(accelX*accelY*accelZ);
     if(!Float.isNaN(accelerationValue)){
    batteryLevel = batteryLevel + accelerationValue;
     //println(batteryLevel);
     }
     if(batteryLevel>1){
     batteryLevel = batteryLevel - decreaseValue;
     }
     
   }
   
   void visualization(){
   
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
  stroke(255,0,0);
  strokeWeight(5);
  line(0,0,0,accelX*100,accelY*100,accelZ*100);
  popMatrix();
  stroke(255, 0, 0);
  strokeWeight(5);
  fill(255, 0, 0);
  noStroke();
  rect(width/2, 20, accelZ*100, 10);
   }
   
  void gyroVisualization(){
    background(20);
    int circleSize = 300;
    
    pushMatrix();
    
    noFill();
    translate(width/2,height/2);
    
    pushMatrix();
    rotateZ(radians(map(gyroZ, -10, 10, 0, 180)));
    //rotateX(radians(map(magX, -10, 10, 0, 180)));
    //rotateY(radians(map(magY, -10, 10, 0, 180)));
    
    stroke(255,0,0);
    ellipse(0,0,circleSize,circleSize);
    line(0,circleSize/2,0,0);
    pushMatrix();
    stroke(255,255,0);
    rotateX(radians(90));
    ellipse(0,0,circleSize,circleSize);
    line(0,circleSize/2,0,0);
    popMatrix();
    pushMatrix();
    stroke(0,255,0);
    rotateY(radians(90));
    ellipse(0,0,circleSize,circleSize);
    line(0,circleSize/2,0,0);
    popMatrix();
    popMatrix();
    popMatrix();
    
    
  }
  
  
