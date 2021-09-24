float periodPx = 24.0;

/// Slider
int sliderValue = 0;
int sliderMin = 0;
int sliderMax = 120;
int sliderHeight = 15;
int startX = 500;
int startY = 300;
int sliderWidth = 200;
float position;
void slider() {
  stroke(0);
  line(startX, startY+sliderHeight, startX+sliderWidth, startY+sliderHeight);
  position = map(sliderValue, sliderMin, sliderMax, 0, sliderWidth );
  println(position);
  fill(255);
  circle(startX+position, startY+sliderHeight, sliderHeight);
  fill(0);
  textSize(32);
  text("Period (0-5):", startX, startY-25);
}

/// Graph
int graphStartX = 50;
int graphStartY = 50;
int graphWidth = 900;
int graphHeight = 150;
void graph() {
  stroke(0);
  line(graphStartX, graphStartY, graphStartX, graphStartY+graphHeight);
  line(graphStartX, graphStartY+graphHeight, graphStartX+graphWidth, graphStartY+graphHeight);
  stroke(60);
  line(graphStartX, graphStartY+(graphHeight/2), graphStartX+graphWidth, graphStartY+(graphHeight/2));
  for (int i = 0; i < graphWidth; i++)
  {
    float startY = (graphHeight/2)*-sin(TWO_PI/sliderValue*i);
    float endY = (graphHeight/2)*-sin(TWO_PI/sliderValue*(i+1));
    line(graphStartX+i, graphStartY+(graphHeight/2)+startY, graphStartX+i+1, graphStartY+(graphHeight/2)+endY);
  }
  if (mouseX > graphStartX && mouseX <= graphStartX + graphWidth && mouseY > graphStartY && mouseY <= graphStartY + graphHeight)
  {
    float pos = mouseX - graphStartX;
    float point = (graphHeight/2)*-sin(TWO_PI/sliderValue*pos);
    fill(255,30,30);
    stroke(255,30,30);
    circle(graphStartX+pos,graphStartY+(graphHeight/2)+point,5);
  }
}

/// Info
int infoStartX = 50;
int infoStartY = 250;
int infoHeight = 104;
int infoWidth = 400;
void info() {
  stroke(0);
  fill(255);
  rect(infoStartX, infoStartY, infoWidth, infoHeight);
  fill(0);
  textSize(16);
  if (sliderValue== 0) return;
  String period = "Period: " + sliderValue/periodPx;
  text(period, infoStartX + 4, infoStartY+20);
  String freq = "Frequency: " + 1/(sliderValue/periodPx);
  text(freq, infoStartX + 4, infoStartY+40);
  String periodWidth = "Lambda (px): " + sliderValue;
  text(periodWidth, infoStartX + 4, infoStartY+60);
  if (mouseX <= graphStartX || mouseX > graphStartX+ graphWidth || mouseY <= graphStartY || mouseY > graphStartY+graphHeight) return;
  String pos = "Position (px): "+ str(mouseX - graphStartX);
  text(pos, infoStartX + 4, infoStartY+80); 
  String amplitude = "Amplitude (%): "+ str(sin(TWO_PI/sliderValue*(mouseX - graphStartX)));
  text(amplitude, infoStartX + 4, infoStartY+100);
}

void setup() {
  size(1000, 400);
  background(204);
}


void draw() {
  background(204);
  slider();
  graph();
  info();
}
void mouseDragged() 
{
  if (mouseX > startX+position-(sliderHeight/2) && mouseX < startX+position+(sliderHeight/2) && mouseY > startY+(sliderHeight*0.5) && mouseY < startY+(sliderHeight*1.5))
  {
    float newPosition = mouseX-startX;
    //println(newPosition);
    if (newPosition > sliderWidth) newPosition = sliderWidth;
    if (newPosition < 0) newPosition = 0;
    sliderValue = int(map(newPosition, 0, sliderWidth, sliderMin, sliderMax));
  }
}
