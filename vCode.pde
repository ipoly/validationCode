class VCode {
  PGraphics pg;
  PImage img;
  String str;
  int tSize = 25, shift = 5, grid = 10, h, w;
  View v;

  VCode() {
    init();
  }

  VCode(int tSize_) {
    init();
    tSize = tSize_;
  }

  void init() {
    str = "SC8";
    pg = createGraphics(width, height, P3D);
    v = new View();
    noiseDetail(2, 0.39);
  }

  void getImg() {
    pg.beginDraw();
    pg.textSize(tSize);
    pg.textAlign(LEFT, BOTTOM);
    pg.background(0);
    pg.fill(grid);
    pg.text(str, shift, tSize+shift);
    pg.endDraw();
    textSize(tSize);
    img = pg.get(0, 0, (int)textWidth(str)+shift, tSize+shift*2);
    img.loadPixels();
    h = img.height;
    w = img.width;
  }

  void drawGrid() {
    pg.pushMatrix();
    pg.fill(255);
    
    pg.translate(-w*grid/2,-h*grid/2);
    
    for (int x = 0; x < w-1; x++) {
      for (int y = 0; y < h-1; y++) {
        PVector p1 = new PVector(x, y, 0), 
        p2 = p1.get(), 
        p3 = p1.get(), 
        p4 = p1.get();

        p2.add(0, 1, 0);
        p3.add(1, 1, 0);
        p4.add(1, 0, 0);

        zSet(p1);
        zSet(p2);
        zSet(p3);
        zSet(p4);

        pg.beginShape();
        pg.vertex(p1.x, p1.y, p1.z);
        pg.vertex(p2.x, p2.y, p2.z);
        pg.vertex(p3.x, p3.y, p3.z);
        pg.vertex(p4.x, p4.y, p4.z);     
        pg.endShape(CLOSE);
      }
    }
    
    pg.popMatrix();
  }

  void dragging() {
    v.dragging();
  }

  void update() {
    pg.beginDraw();
    pg.lights();
    pg.background(255);
    pg.translate(width/2, height/2, -300);
    pg.rotateX(radians(30));

    v.rotate(pg);
    drawGrid();

    pg.endDraw();
  }

  void zSet(PVector p) {
    color[] pix = img.pixels;
    int x = (int)p.x, y = (int)p.y;
    p.z = map(noise(x/10.0, y/10.0), 0, 1, 0, 10) + (float)brightness(pix[x + y*img.width])/grid*1.5;
    p.mult(grid);
  }

  void display() {
    image(pg, 0, 0);
  }
}

