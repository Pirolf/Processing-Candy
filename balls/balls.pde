void setup() {
  size(960, 540);
  colorMode(HSB, 360, 100, 100);
}

float radius = 100; 
void draw() {
  background(50);
  radius = map(sin(frameCount / 16.0), -1, 1, 50, 100); 
  fill(map(mouseX, 0, 960, 0, 360), 90, map(mouseY, 0, 540, 60, 100));
  ellipse(mouseX, mouseY, radius, radius);
}