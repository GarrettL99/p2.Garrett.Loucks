PImage bg;
PImage sun;
PImage moon;
Table calendar;
int itimesec, itimemin, itimehour;
String[] stimesec, stimemin, stimehour;
String sstimesec, sstimemin, sstimehour;
int rectX, rectY;
boolean rectOver = false;
int rectSize;

void setup() {
  size(552, 418);
  bg = loadImage("bathroom.jpg");
  moon = loadImage("moon.png");
  sun = loadImage("sun.png");
  frameRate(60);
  stimesec = loadStrings("mirrortimesec.txt");
  stimemin = loadStrings("mirrortimemin.txt");
  stimehour = loadStrings("mirrortimehour.txt");
  sstimesec=stimesec[0];
  sstimemin=stimemin[0];
  sstimehour=stimehour[0];
  itimesec = int(sstimesec);
  itimemin = int(sstimemin);
  itimehour = int(sstimehour);
  rectSize = 90;
  rectX = 300;
  rectY = 315;
}

void draw() {
  update(mouseX, mouseY);
  background(bg);
  int m = minute();
  int h = hour();
  
  int d = day();
  int mth = month();
  int y = year();
  
  textSize(30);
  fill(0);
  
  //after noon
  if(h>12){
    if(m<10){
      text(h-12+" : 0"+m,390,70);
    }
    else{
      text(h-12+" : "+m,390,70);
    }
  }
  
  //before noon
  else{
    if(m<10){
      text(h+" : 0"+m,390,70);
    }
    else{
      text(h+" : "+m,390,70);
    }
  }
  
  text(mth +" / " +d+" / "+y,340,100);
  
  textSize(12);
  
  if(itimesec==60){
    itimemin++;
    itimesec=0;
  }
  if(itimemin==60){
    itimehour++;
    itimemin=0;
  }
  if(frameCount %60 == 0){
    itimesec++;
  }
  
  
  text("You have used this mirror for " +itimehour + " hours, " + itimemin + " minutes and " + itimesec + " seconds", 190,310);
  
  
  
  //mirror timer
  sstimesec = str(itimesec);
  stimesec = split(sstimesec,' ');
  sstimemin = str(itimemin);
  stimemin = split(sstimemin,' ');
  sstimehour = str(itimehour);
  stimehour = split(sstimehour,' ');
  
  //mirror timer reset button
  if(rectOver){
    fill(69,69,69);
  }
  else{
    fill(143,143,143);
  }
  rect(rectX,rectY,rectSize,rectSize/2);
  textSize(30);
  fill(255);
  text("Reset",rectX+10, rectY+35);
  //weather
  if(h<18){
    image(sun,50,50);
  }
  if(h>=18){
    image(moon,30,30);
  }
  saveStrings("mirrortimesec.txt", stimesec);
  saveStrings("mirrortimemin.txt", stimemin);
  saveStrings("mirrortimehour.txt", stimehour);
}

void update(int x, int y){
  if(overRect(rectX, rectY, rectSize, rectSize)){
    rectOver = true;
  }
  else{
    rectOver = false;
  }
}
void mousePressed(){
  if(rectOver){
    itimesec = 0;
    itimemin = 0;
    itimehour = 0;
  }
}

boolean overRect(int x,int y,int width,int height){
  if(mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY<= y+height){
    return true;
  }
  else{
    return false;
  }
}
