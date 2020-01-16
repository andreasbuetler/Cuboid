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
