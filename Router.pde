class Router {
  int maxToSend;
  int [] graphColor;
  int [] slider;
  float [] result;
  float[] valorViejo;
  float[] valor;
  boolean [] SEND;
  boolean [] RECEIVE;
  Chart [] grafico;
  Chart [] graficoOut;
  Router(int cantidadDeCanales) {
    canalIn0 = "/wimumo001/emg/ch1";
    canalIn1 = "/wimumo001/emg/ch2";
    canalIn2 = "/wimumo001/emg/ch3";
    canalIn3 = "/wimumo001/emg/ch4";
    this.maxToSend = 1000;
    this.slider = new int[cantidadDeCanales];
    this.grafico = new Chart[cantidadDeCanales];
    this.graficoOut = new Chart[cantidadDeCanales];
    this.result =  new float[cantidadDeCanales];
    this.valor =  new float[cantidadDeCanales];
    this.grafico[0] = grafico0;
    this.grafico[1] = grafico1;
    this.grafico[2] = grafico2;
    this.grafico[3] = grafico3;
    this.graficoOut[0] = graficoOut0;
    this.graficoOut[1] = graficoOut1;
    this.graficoOut[2] = graficoOut2;
    this.graficoOut[3] = graficoOut3;
    for (int i = 0; i < cantidadDeCanales; i++) {
      this.valor[i] = 0;
      this.result[i] = 0;
      this.slider[i] = 0;
      campoDeTexto(i);
      sliderDeSaturacion(i);
      toggles(i);
      modulosOSC(i);
      graficos(i);
      graficosOut(i);
    }
  }
  void actualizar() {
    background(0);
    this.slider[0] = saturacion0;
    this.slider[1] = saturacion1;
    this.slider[2] = saturacion2;
    this.slider[3] = saturacion3;
    for (int i = 0; i < cantidadDeCanales; i++) {
      modulosOSC(i);
      this.result[i] = (this.valor[i] / this.slider[i]);
      this.grafico[i].push(this.valor[i]);
      this.graficoOut[i].push(this.result[i]);
    }
    if (SEND0 == false) {
      this.result[0] = 0;
    } else if (SEND1 == false) {
      this.result[1] = 0;
    } else if (SEND2 == false) {
      this.result[2] = 0;
    } else if (SEND3 == false) {
      this.result[3] = 0;
    }
    OscMessage myMessage = new OscMessage(canalOut);
    String m = this.result[0]+"/"+this.result[1]+"/"+this.result[2]+"/"+this.result[3];
    myMessage.add(m);
    if (SEND0 == false) {
      this.result[0] = 0;
    } else if (SEND1 == false) {
      this.result[1] = 0;
    } else if (SEND2 == false) {
      this.result[2] = 0;
    } else if (SEND3 == false) {
      this.result[3] = 0;
    }
    if (RECEIVE0 == true && SEND0 == true ||
      RECEIVE1 == true && SEND1 == true ||
      RECEIVE2 == true && SEND2 == true ||
      RECEIVE3 == true && SEND3 == true) {
      oscP5.send(myMessage, ipRemoto);
      if (mousePressed) {
        fill(0, 255, 0);
        text("This host: "+currentHost+":12000", mouseX, mouseY);
        text("Sending to: "+ipRemoto+canalOut, mouseX, mouseY+20);
        text("MIT", mouseX, mouseY+40);
      } else {
        fill(255);
      }
    }
  }
  void graficos(int canal) {
    this.grafico[canal] = cp5.addChart("grafico"+canal)
      .setPosition(width/5, height/cantidadDeCanales*canal+height/12)
      .setSize(50, 50)
      .setRange(-1000, 100000)
      .setView(Chart.LINE)
      .setStrokeWeight(1.5)
      .setColorCaptionLabel(color(255))
      ; 
    this.grafico[canal].addDataSet("grafico"+canal);
    this.grafico[canal].setData("grafico"+canal, new float[360]);
  }
  void graficosOut(int canal) {
    this.graficoOut[canal] = cp5.addChart("graficoOut"+canal)
      .setPosition(width-width/5, height/cantidadDeCanales*canal+height/12)
      .setSize(50, 50)
      .setRange(-1000, 1000)
      .setView(Chart.LINE)
      .setStrokeWeight(1.5)
      .setColorCaptionLabel(color(255))
      ; 
    this.graficoOut[canal].addDataSet("graficoOut"+canal);
    this.graficoOut[canal].setData("graficoOut"+canal, new float[360]);
  }
  void modulosOSC(int canal) {
    pushMatrix();
    stroke(255);
    text("Recibido: ", width/9, height/cantidadDeCanales*canal+height/10);
    text(valor[canal], width/9, height/cantidadDeCanales*canal+height/8);
    text("Enviado: ", width-width/3.5, height/cantidadDeCanales*canal+height/10);
    text(result[canal], width-width/3.5, height/cantidadDeCanales*canal+height/7);
    if (valor[canal] >= 0.1) {
      fill(0, 255, 0, 255);
      square(width/6, height/cantidadDeCanales*canal+height/7, 5);
    }
    popMatrix();
  }
  void sliderDeSaturacion(int canal) {
    cp5.addSlider("saturacion"+canal)
      .setPosition(width/3, height/cantidadDeCanales*canal+height/48)
      .setSize(width/3, 10)
      .setRange(1, this.maxToSend)
      ;
  }
  void campoDeTexto(int canal) {
    cp5.addTextfield("canalIn"+canal)
      .setPosition(width/3, height/cantidadDeCanales*canal+height/12)
      .setSize(width/6, height/cantidadDeCanales/5)
      .setFont(createFont("arial", 14))
      .setAutoClear(false)
      ;
  }
  void toggles(int canal) {
    cp5.addToggle("RECEIVE"+canal)
      .setPosition(0, height/cantidadDeCanales*canal)
      .setSize(width/10, height/cantidadDeCanales)
      ;
    cp5.addToggle("SEND"+canal)
      .setPosition(width-width/10, height/cantidadDeCanales*canal)
      .setSize(width/10, height/cantidadDeCanales)
      ;
  }
}
