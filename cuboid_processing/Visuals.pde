void visualization() {

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

void gyroVisualization() {
  background(20);
  int circleSize = 300;

  pushMatrix();

  noFill();
  translate(width/2, height/2);

  pushMatrix();
  rotateZ(radians(map(gyroZ, -10, 10, 0, 180)));
  //rotateX(radians(map(magX, -10, 10, 0, 180)));
  //rotateY(radians(map(magY, -10, 10, 0, 180)));

  stroke(255, 0, 0);
  ellipse(0, 0, circleSize, circleSize);
  line(0, circleSize/2, 0, 0);
  pushMatrix();
  stroke(255, 255, 0);
  rotateX(radians(90));
  ellipse(0, 0, circleSize, circleSize);
  line(0, circleSize/2, 0, 0);
  popMatrix();
  pushMatrix();
  stroke(0, 255, 0);
  rotateY(radians(90));
  ellipse(0, 0, circleSize, circleSize);
  line(0, circleSize/2, 0, 0);
  popMatrix();
  popMatrix();
  popMatrix();
}
