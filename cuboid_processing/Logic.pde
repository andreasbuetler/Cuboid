float maxBatteryLevel = 100;
float shootThreshold = 3;
float accelerationValue;
boolean shoot = false;
float batteryLevel = 0;
boolean charging = false;
boolean noMovement = true;
boolean impact = false;
float chargingThresholdLow = 0.005;
int chargingCounter = 5;

//  void shootDetection() {
//  if (accelerationValue >= shootThreshold) {
//    shoot = true;
//    println("shoot");
//  } else {
//    shoot = false;
//  }
//}

void batteryLevel() {
  //println("batteryLevel()");
  float decreaseValue = 0.1;
  if(!Float.isNaN(accelX)&&!Float.isNaN(accelY)&&!Float.isNaN(accelZ)){
  //accelerationValue = accelerationValue*0.7+abs(accelX*accelY*accelZ)*0.3;
  accelerationValue = abs(accelX*accelY*accelZ);
  }
  if (!Float.isNaN(accelerationValue)&&accelerationValue<=maxBatteryLevel) {
     if(batteryLevel < 100){
    batteryLevel = batteryLevel + accelerationValue;
    
     }
  }
  if (batteryLevel>1) {
    batteryLevel = batteryLevel - decreaseValue;
  }
  println(batteryLevel);
}

void MovementDetection() {
   println("MovementDetection()");
    //println("AccValue:"+accelerationValue);
    //println(accelerationValue);
      if (accelerationValue>shootThreshold) {
      
    charging = false;
    shoot = true;
    //println(shoot);
    impact = true;
    noMovement = false;
    //impact();
    //reset Chanrging Value
    //batteryLevel = 0;
    //oscHandler();
  }else{
    shoot = false;
    impact = false;
  }
    
  if (accelerationValue<chargingThresholdLow) {
    println("NO MOVEMENT");
    charging = false;
    shoot = false;
    noMovement = true;
    impact = false;
  }

  if (accelerationValue>chargingThresholdLow&&accelerationValue<shootThreshold) {
    println("CHARGING");
    if (chargingCounter<7){
      charging = false;
      chargingCounter++;
    }else{
    charging = true;
    chargingCounter = 0;
    }
    shoot = false;
    noMovement = false;
    impact = false;
  }
  println("charging:"+ charging);
}

//void impact () {
//  //println("impact ()");
//  //delay(2000);

//  impact = true;
 
//}
