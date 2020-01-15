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

void setup(){
  size(600, 640,FX2D); 
  frameRate(120);
  
  myClient = new Client(this, "192.168.1.77", 80);
  oscP5 = new OscP5(this, 12000);
  
   if(!clientConnected){
        clientConnected=true;
      }
   valF = new float[5];
   for (int i = 0; i < valF.length;i++){
    valF[i]=0.0;
   }
  
}

void draw(){
  readClient();
  println(" X= "+valF[0]+" Y= "+valF[1]+" Z= "+valF[2]);
}

String values="";
void readClient(){

    if(clientConnected){
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
        if(list.length>0){
          for(int i=0; i < list.length;i ++){
            list[i]=list[i].replaceAll("!","");
            if(list.length==3){
            valF[0]=float(list[0]); // magnetometer.x
            valF[1]=float(list[1]); // magnetometer.y
            valF[2]=float(list[2]); // magnetometer.z
            //valF[3]=float(list[3]); // cap sensing value
            // valF[4]=float(list[4]); ... and so on
            }
          }
        }     
      } 
    }
}
