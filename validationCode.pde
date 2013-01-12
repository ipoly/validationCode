VCode vc;

void setup() {
  size(600, 300, P3D);
  frameRate(30);
  vc = new VCode();
  vc.getImg();
  vc.update();
}

void draw() {
  background(255);
  vc.display();
}

void mouseDragged() {
}

