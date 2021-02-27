import controlP5.*;
import processing.sound.*;
import guru.ttslib.*;

ControlP5 cp5;
TTS tts = new TTS();
Slider slider;
int kySlider;
int startingTime;
boolean show = false;
boolean countdownCompleted = false;
int currentTimeInMillis;
PFont mono;
String audioName = "Microwave_sound.mp3";
String path;
SoundFile file;

void setup () {
  size (1500, 800);
  background (97);
  smooth ();
  PFont.list();
  mono = createFont("digital.ttf",25);
  textFont(mono);
  fill (255);
  rect (50, 50, 1400, 700, 40);
  smooth ();
  fill (240);
  rect (100, 100, 1300, 600, 40);
  line (1000, 100, 1000, 700);
  fill (255);
  rect (200, 180, 700, 440, 20);
  fill (0);
  rect (1050, 120, 300, 100);
  fill (255);
  textSize(22);
  text ("Press any minute key to start!", 1052, 180);
  cp5 = new ControlP5(this);
  ControlFont cf1 = new ControlFont(createFont("DroidSansBold.ttf", 14));
  ControlFont cf2 = new ControlFont(createFont("DroidSansBold.ttf", 20));
  cp5.addButton("1").setSize(60, 50).setPosition(1100, 430).setColorBackground(color(0)).setFont(cf2);
  cp5.addButton("2").setSize(60, 50).setPosition(1180, 430).setColorBackground(color(0)).setFont(cf2);
  cp5.addButton("3").setSize(60, 50).setPosition(1260, 430).setColorBackground(color(0)).setFont(cf2);
  cp5.addButton("4").setSize(60, 50).setPosition(1100, 500).setColorBackground(color(0)).setFont(cf2);
  cp5.addButton("5").setSize(60, 50).setPosition(1180, 500).setColorBackground(color(0)).setFont(cf2);
  cp5.addButton("6").setSize(60, 50).setPosition(1260, 500).setColorBackground(color(0)).setFont(cf2);
  cp5.addButton("7").setSize(60, 50).setPosition(1100, 570).setColorBackground(color(0)).setFont(cf2);
  cp5.addButton("8").setSize(60, 50).setPosition(1180, 570).setColorBackground(color(0)).setFont(cf2);
  cp5.addButton("9").setSize(60, 50).setPosition(1260, 570).setColorBackground(color(0)).setFont(cf2);
  cp5.addButton("0").setSize(60, 50).setPosition(1180, 640).setColorBackground(color(0)).setFont(cf2);
  cp5.addButton("High").setSize(90, 70).setPosition(1050, 240).setColorBackground(color(0)).setFont(cf1);
  cp5.addButton("Medium").setSize(90, 70).setPosition(1270, 240).setColorBackground(color(0)).setFont(cf1);
  cp5.addButton("Off/Clear").setSize(90, 70).setPosition(1050, 330).setColorBackground(color(0)).setFont(cf1);
  cp5.addButton("Add 30Secs").setSize(90, 70).setPosition(1270, 330).setColorBackground(color(0)).setFont(cf1);
  cp5.addButton("Defrost").setSize(90, 70).setPosition(1160, 285).setColorBackground(color(0)).setFont(cf1);
  cp5.addButton("Open | Close").setSize(120, 50).setPosition(860, 640).setColorBackground(color(0)).setFont(cf1);
}

void draw() {
  timer();
  PFont.list();
  mono = createFont("digital.ttf", 32);
  textFont(mono);
  textSize(32);
}

//arrays showing positions of buttons

int[] xPositions = {1180, 1100, 1180, 1260, 1100, 1180, 1260, 1100, 1180, 1260};
int[] yPositions = {640, 430, 430, 430, 500, 500, 500, 570, 570, 570};

boolean isAdd30SecondsClicked(int xPositionClicked, int yPositionClicked) {
  if ( (xPositionClicked >= 1270 && xPositionClicked <= 1270 + 90) &&
    (yPositionClicked >= 330 && yPositionClicked <= 330 + 70)) {
    return true;
  }
  return false;
}

boolean isClearClicked(int xPositionClicked, int yPositionClicked) {
  if ( (xPositionClicked >= 1050 && xPositionClicked <= 1050 + 90) &&
    (yPositionClicked >= 330 && yPositionClicked <= 330 + 70)) {
    return true;
  }
  return false;
}

boolean isHighClicked(int xPositionClicked, int yPositionClicked) {
  if ( (xPositionClicked >= 1050 && xPositionClicked <= 1050 + 90) &&
    (yPositionClicked >= 240 && yPositionClicked <= 240 + 70)) {
    return true;
  }
  return false;
}

boolean isMediumClicked(int xPositionClicked, int yPositionClicked) {
  if ( (xPositionClicked >= 1270 && xPositionClicked <= 1270 + 90) &&
    (yPositionClicked >= 240 && yPositionClicked <= 240 + 70)) {
    return true;
  }
  return false;
}

boolean isDefrostClicked(int xPositionClicked, int yPositionClicked) {
  if ( (xPositionClicked >= 1160 && xPositionClicked <= 1160 + 90) &&
    (yPositionClicked >= 285 && yPositionClicked <= 285 + 70)) {
    return true;
  }
  return false;
}

boolean isOpen(int xPositionClicked, int yPositionClicked) {
  if ( (xPositionClicked >= 860 && xPositionClicked <= 860 + 50) &&
    (yPositionClicked >= 640 && yPositionClicked <= 640 + 50)) {
    return true;
  }
  return false;
}

boolean isClose(int xPositionClicked, int yPositionClicked) {
  if ( (xPositionClicked >= 920 && xPositionClicked <= 920 + 50) &&
    (yPositionClicked >= 640 && yPositionClicked <= 640 + 50)) {
    return true;
  }
  return false;
}

void mouseClicked() {
  for (int i = 0; i < 10; i++) {
    //if the mouse is in the box
    if ( (mouseX >= xPositions[i] && mouseX <= xPositions[i] + 60) &&
      (mouseY >= yPositions[i] && mouseY <= yPositions[i] + 50) && !show) {
      show = true;  //turns show on and off
      fill(255);
      startingTime = i*60*1000+millis();
      fill(255);
    }
  }
  if (isAdd30SecondsClicked(mouseX, mouseY)) {
    show = true;
    println(currentTimeInMillis);
    startingTime = currentTimeInMillis + (31*1000) + millis();
    //currentTimeInMillis += 30 * 1000;
  } else if (isClearClicked(mouseX, mouseY)) {
    show = false;
    currentTimeInMillis = 0;
    fill (255);
    rect (200, 180, 700, 440, 20);
    fill(0);
    rect (1050, 120, 300, 100);
    fill (255);
    textSize(22);
    text ("Press any minute key to start!", 1052, 180);
  } else if (isHighClicked(mouseX, mouseY)) {
    show = false;
    currentTimeInMillis = 0;
    fill (255);
    rect (200, 180, 700, 440, 20);
    fill(0);
    rect (1050, 120, 300, 100);
    fill (255);
    textSize(22);
    text ("High", 1065, 150);
 } else if (isMediumClicked(mouseX, mouseY)) {
    show = false;
    currentTimeInMillis = 0;
    fill (255);
    rect (200, 180, 700, 440, 20);
    fill(0);
    rect (1050, 120, 300, 100);
    fill (255);
    textSize(22);
    text ("Medium", 1065, 150);
 } else if (isDefrostClicked(mouseX, mouseY)) {
   show = false;
    currentTimeInMillis = 0;
    fill (255);
    rect (200, 180, 700, 440, 20);
    fill(0);
    rect (1050, 120, 300, 100);
    fill (255);
    textSize(22);
    text ("Defrost", 1065, 150);
  } else if (isOpen(mouseX, mouseY)) {
    show = false;
    currentTimeInMillis = 0;
    fill (255, 217, 102);
    rect (200, 180, 700, 440, 20);
    fill(0);
    rect (1050, 120, 300, 100);
    fill (255);
    ellipse (550,450,370,180);
    fill (230);
    textSize(32);
    text ("MICROWAVE OPEN", 1105, 180);
    } else if (isClose(mouseX, mouseY)) {
    show = false;
    currentTimeInMillis = 0;
    fill (255);
    rect (200, 180, 700, 440, 20);
    fill(0);
    rect (1050, 120, 300, 100);
    fill (230);
    textSize(22);
    text ("Press any minute key to start!", 1052, 180);
  }
}


void timer() {

  if (show) {
    countdownCompleted = false;
    currentTimeInMillis = startingTime - millis();
    int currentTime = currentTimeInMillis / 1000;
    int minutes = currentTime / 60;
    int hours = minutes/60;
    currentTime -= minutes * 60;
    minutes -= hours * 60;
    fill(0, 0, 0);
    rect (1050, 120, 300, 100);
    fill (255, 217, 102);
    rect (200, 180, 700, 440, 20);
    fill(255);
    //file = new SoundFile(this, "microwaveRunning.mp3");
    //file.play();
    //fill(255);
    text((minutes) + ":" + (currentTime), 1285, 200);

    if (currentTimeInMillis <= 0) {
      show = false;
      countdownCompleted = true;
    }
  } else if (countdownCompleted) {
    fill (255);
    rect (200, 180, 700, 440, 20);
    fill(0);
    rect (1050, 120, 300, 100);
    fill (255);
    textSize(25);
    text ("Food is Ready!!!", 1120, 180);
    println("Food is Ready!!!");
    file = new SoundFile(this, "Microwave_bell.mp3");
    file.play();
    tts.speak("Food is Ready!!!");
    noLoop ();  //stop loop
    //return;
    //break;
  }
}
