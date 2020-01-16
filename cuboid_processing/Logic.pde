void shootDetection() {
  if (accelerationValue >= shootThreshold) {
    shoot = true;
  } else {
    shoot = false;
  }
}

void batteryLevel() {
  float decreaseValue = 1;
  accelerationValue = abs(accelX*accelY*accelZ);
  if (!Float.isNaN(accelerationValue)&&accelerationValue<=maxBatteryLevel) {

    batteryLevel = batteryLevel + accelerationValue;
    //println(batteryLevel);
  }
  if (batteryLevel>1) {
    batteryLevel = batteryLevel - decreaseValue;
  }
}
