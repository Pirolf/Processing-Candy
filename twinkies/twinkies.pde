class Circle {
  float x, y, r;
  Circle(float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
  }
  
  void pulse(String type) {
    float pulseFactor = 1.0;
    // FIXME: https://processing.org/reference/bezierPoint_.html    
    double sinStep = millis()/1000.0;
    switch(type){
      case "fluid": pulseFactor = norm(sin((float)sinStep + x*y),-1,1); break;
    }
    scale(pulseFactor);
  }

  void draw() {
    pushMatrix();
    translate(x,y);
    float max_dist = dist(0,0,width/2.0, height/2.0);
    float dist = dist(x,y,width/2.0, height/2.0);
    float dist_diff = max_dist-dist;
    float hue = map(dist_diff,0, max_dist, 100, 343 );
    float s =  map(dist_diff,0, max_dist, 40, 80);
    float b = map(dist_diff,0, max_dist, 10, 98);
    fill(hue, s, b);
    stroke(hue,s/2.0,b/2.0);
    pulse("fluid");
    ellipse(0,0,r,r);
    popMatrix();
  }
}

Circle createCircle() {
  float x = map(randomGaussian(), -3, 3, 0.05, 0.95) * width;
  float y = map(randomGaussian(), -3, 3, 0.05, 0.95) * height;
  float max_dist = dist(0,0,width/2.0, height/2.0);
  float dist = map(max_dist-dist(x,y,width/2.0, height/2.0),0,max_dist,0,11);
  float r = map(randomGaussian(), -3, 3, 0.05, 0.95) * dist;
  return new Circle(x,y,r);
}

Circle[] circles;
int count = 400;

void setupScene() {
  circles = new Circle[count];
  for(int i = 0; i < count; i++) {
    circles[i] = createCircle();
  }
}

void setup() {
  fullScreen();
  pixelDensity(displayDensity());
  colorMode(HSB, 360, 100, 100);
  rectMode(CENTER);
  smooth(8);
  background(10);
  setupScene();
}

void mouseClicked() {
  setupScene();  
}

void draw() {
  background(10);
  for(int i=0; i < count; i++) {
    circles[i].draw();
  }
}