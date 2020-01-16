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

float actualAccZ;
String directionZ="";



void getCalibratedValues() {
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

void directionRotZ() {
  actualAccZ = accelZ-resetAccZ;
  if (actualAccZ <0 ) {
    directionZ ="Left";
  } else {
    directionZ="right";
  }
  //println(directionZ);
}


void printAllValues() {
  println("Magnetometer: "+"\t"+"X = "+TmagX+"\t"+"Y = "+TmagY+"\t"+"Z = "+TmagZ);
  println("Acceleration: "+"\t"+"X = "+TaccelX+"\t"+"Y = "+TaccelY+"\t"+"Z = "+TaccelZ);
  println("Gyro: "+"\t\t"+"X = "+TgyroX+"\t"+"Y = "+TgyroY+"\t"+"Z = "+TgyroZ);
}
