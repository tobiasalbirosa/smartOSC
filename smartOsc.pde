import oscP5.*;
import netP5.*;
import controlP5.*;
ControlP5 cp5;
NetAddress ipRemoto;
OscP5 oscP5;
Router router;
String m, canalOut, currentHost;
int cantidadDeCanales = 8;
float m1, m2, m3, m4, m5, m6, m7, m8;
String canalIn0, canalIn1, canalIn2, canalIn3, canalIn4, canalIn5, canalIn6, canalIn7;
int slider0, slider1, slider2, slider3, slider4, slider5, slider6, slider7;
boolean RECEIVE0, RECEIVE1, RECEIVE2, RECEIVE3, RECEIVE4, RECEIVE5, RECEIVE6, RECEIVE7;
boolean SEND0, SEND1, SEND2, SEND3, SEND4, SEND5, SEND6, SEND7;
Chart grafico0, grafico1, grafico2, grafico3, grafico4, grafico5, grafico6, grafico7;
Chart graficoOut0, graficoOut1, graficoOut2, graficoOut3, graficoOut4, graficoOut5, graficoOut6, graficoOut7;
public void settings() {
  size(displayWidth/2, displayHeight-100);
}
public void setup() {
  slider0 = 1;
  slider1 = 1;
  slider2 = 1;
  slider3 = 1;
  slider4 = 1;
  slider5 = 1;
  slider6 = 1;
  slider7 = 1;
  canalIn0 = "/wimumo001/emg/ch1";
  canalIn1 = "/wimumo001/emg/ch2";
  canalIn2 = "/wimumo001/emg/ch3";
  canalIn3 = "/wimumo001/emg/ch4";
  canalIn4 = "/wimumo001/emg/ch5";
  canalIn5 = "/wimumo001/emg/ch6";
  canalIn6 = "/wimumo001/emg/ch7";
  canalIn7 = "/wimumo001/emg/ch8";
  cp5 = new ControlP5(this);
  frameRate(30);
  try {
    println(java.net.InetAddress.getLocalHost().getHostAddress());
    currentHost = java.net.InetAddress.getLocalHost().getHostAddress();
  } 
  catch(Exception e) {
    currentHost = "0.0.0.0";
  }
  oscP5 = new OscP5(this, 12000);
  ipRemoto = new NetAddress("localhost", 6000);
  canalOut = "/message";
  surface.setResizable(true);
  router = new Router(cantidadDeCanales);
}  
void draw() {
  background(0);
  router.actualizar();
  Runtime.getRuntime().runFinalization();
}
