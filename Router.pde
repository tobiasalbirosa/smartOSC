class Router {
  boolean verMenu;
  int toMB = 1024 * 1024;
  float currentMouseX, currentMouseY;
  int [] graphColor;
  float [] exp;
  float [] slider;
  float [] result;
  float[] valorViejo;
  float[] valor;
  boolean [] SEND;
  boolean [] RECEIVE;
  Chart [] grafico;
  Chart [] graficoOut;
  Router(int cantidadDeCanales) {
    this.exp =  new float[cantidadDeCanales];
    this.slider = new float[cantidadDeCanales];
    this.grafico = new Chart[cantidadDeCanales];
    this.graficoOut = new Chart[cantidadDeCanales];
    this.result =  new float[cantidadDeCanales];
    this.valor =  new float[cantidadDeCanales];
    this.grafico[0] = grafico0;
    this.grafico[1] = grafico1;
    this.grafico[2] = grafico2;
    this.grafico[3] = grafico3;
    this.grafico[4] = grafico4;
    this.grafico[5] = grafico5;
    this.grafico[6] = grafico6;
    this.grafico[7] = grafico7;
    this.graficoOut[0] = graficoOut0;
    this.graficoOut[1] = graficoOut1;
    this.graficoOut[2] = graficoOut2;
    this.graficoOut[3] = graficoOut3;
    this.graficoOut[4] = graficoOut4;
    this.graficoOut[5] = graficoOut5;
    this.graficoOut[6] = graficoOut6;
    this.graficoOut[7] = graficoOut7;
    for (int i = 0; i < cantidadDeCanales; i++) {
      this.valor[i] = 0;
      this.result[i] = 0.5;
      this.slider[i] = 0;
      campoDeTexto(i);
      sliders(i);
      toggles(i);
      modulosOSC(i);
      graficos(i);
      graficosOut(i);
    }
  }
  void actualizar() {
    
    for (int i = 0; i < cantidadDeCanales; i++) {
      modulosOSC(i);
      if (this.valor[i] /  this.slider[i] > 0) {
        this.result[i] = (this.valor[i] /  this.slider[i]);
      } else {
        this.result[i] = 0;
      }
      this.result[i] = map( this.result[i], 0, 5000, 0, 1);
      if (this.result[i] > 1) {
        this.result[i] = 1;
      }
      this.grafico[i].push(this.valor[i]);
      this.graficoOut[i].push(this.result[i]);
    }
    this.slider[0] = slider0;
    this.slider[1] = slider1;
    this.slider[2] = slider2;
    this.slider[3] = slider3;
    this.slider[4] = slider4;
    this.slider[5] = slider5;
    this.slider[6] = slider6;
    this.slider[7] = slider7;
    if (SEND0 == false) {
      this.result[0] = 0;
    }  
    if (SEND1 == false) {
      this.result[1] = 0;
    }  
    if (SEND2 == false) {
      this.result[2] = 0;
    }  
    if (SEND3 == false) {
      this.result[3] = 0;
    }  
    if (SEND4 == false) {
      this.result[4] = 0;
    }  
    if (SEND5 == false) {
      this.result[5] = 0;
    }  
    if (SEND6 == false) {
      this.result[6] = 0;
    }  
    if (SEND7 == false) {
      this.result[7] = 0;
    }
    OscMessage myMessage = new OscMessage(canalOut);
    String m = this.result[0]+"/"+this.result[1]+"/"+this.result[2]+"/"+this.result[3] + "/" + this.result[4]+"/"+this.result[5]+"/"+this.result[6]+"/"+this.result[7];
    myMessage.add(m);
    if (
      RECEIVE0 == true && SEND0 == true ||
      RECEIVE1 == true && SEND1 == true ||
      RECEIVE2 == true && SEND2 == true ||
      RECEIVE3 == true && SEND3 == true ||
      RECEIVE4 == true && SEND4 == true ||
      RECEIVE5 == true && SEND5 == true ||
      RECEIVE6 == true && SEND6 == true ||
      RECEIVE7 == true && SEND7 == true ) 
    {
      oscP5.send(myMessage, ipRemoto);
      mouseDetector();
    }
  }
  void mouseDetector() {
    if (mousePressed) {
      fill(0, 255, 0);
      text("This host: "+currentHost+":12000", mouseX, mouseY);
      text("Sending to: "+ipRemoto+canalOut, mouseX, mouseY+20);
      text("MB usados: " + (Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory()) / this.toMB, mouseX, mouseY+40);
      text("MB libres: " + Runtime.getRuntime().freeMemory() / this.toMB, mouseX, mouseY+60);
    } else {
      fill(255);
    }
  }
  void graficos(int canal) {
    this.grafico[canal] = cp5.addChart("grafico"+canal)
      .setPosition(width/5, height/cantidadDeCanales*canal)
      .setSize(50, 50)
      .setRange(0, 5000)
      .setView(Chart.LINE)
      .setStrokeWeight(1.5)
      .setColorCaptionLabel(color(255));
    this.grafico[canal].addDataSet("grafico"+canal);
    this.grafico[canal].setData("grafico"+canal, new float[360]);
  }
  void graficosOut(int canal) {
    this.graficoOut[canal] = cp5.addChart("graficoOut"+canal)
      .setPosition(width-width/5, height/cantidadDeCanales*canal)
      .setSize(50, 50)
      .setRange(0, 1)
      .setView(Chart.LINE)
      .setStrokeWeight(1.5)
      .setColorCaptionLabel(color(255)); 
    this.graficoOut[canal].addDataSet("graficoOut"+canal);
    this.graficoOut[canal].setData("graficoOut"+canal, new float[360]);
  }
  void modulosOSC(int canal) {
    pushMatrix();
    stroke(255);
    text("Recibido: ", width/9, height/cantidadDeCanales*canal+20);
    text(valor[canal], width/9, height/cantidadDeCanales*canal+40);
    text("Enviado: ", width-width/3.5, height/cantidadDeCanales*canal+20);
    text(result[canal], width-width/3.5, height/cantidadDeCanales*canal+40);
    if (valor[canal] >= 0.1) {
      fill(0, 255, 0, 255);
      square(width/6, height/cantidadDeCanales*canal+height/7, 5);
    }
    popMatrix();
  }
  void sliders(int canal) {
    cp5.addSlider("slider"+canal)
      .setPosition(width/3, height/cantidadDeCanales*canal+height/48)
      .setSize(width/3, 10)
      .setRange(1, 100)
      ;
  }
  void sliderInput(int canal) {
    cp5.addTextfield("sliderInput"+canal)
      .setPosition(width/3, height/cantidadDeCanales*canal+height/6)
      .setSize(width/6, height/cantidadDeCanales/5)
      .setFont(createFont("arial", 14))
      .setAutoClear(false)
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
