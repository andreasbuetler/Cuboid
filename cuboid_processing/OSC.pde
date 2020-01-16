void oscHandler() {
  OscMessage value1 = new OscMessage("/value1");
  OscMessage value2 = new OscMessage("/value2");
  OscMessage value3 = new OscMessage("/value3");



  value1.add(map(batteryLevel, 0, maxBatteryLevel, 0, 1)); /* add an int to the osc message */
  value2.add(shoot);
  /* send the message */
  //oscP5.send(value1, myRemoteLocation);
  oscP5.send(value2, myRemoteLocation);
}
