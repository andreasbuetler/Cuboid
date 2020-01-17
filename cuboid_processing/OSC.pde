

void oscHandler() {
  OscMessage value1 = new OscMessage("/value1");
  OscMessage value2 = new OscMessage("/value2");
  OscMessage value3 = new OscMessage("/value3");
  OscMessage value4 = new OscMessage("/value4");  



  value1.add(constrain(map(batteryLevel, 0, maxBatteryLevel, 0, 1),0,maxBatteryLevel)); /* add an int to the osc message */
  value2.add(charging);
  value3.add(shoot);
  value4.add(impact);
  /* send the message */
  oscP5.send(value1, myRemoteLocation);
  delay(10);
   oscP5.send(value2, myRemoteLocation);
     delay(10);
  oscP5.send(value3, myRemoteLocation);
    delay(10);
  //oscP5.send(value4, myRemoteLocation);
}
