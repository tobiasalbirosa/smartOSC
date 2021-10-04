void oscEvent(OscMessage mensaje) {
  println(mensaje);
  if (mensaje.checkAddrPattern(canalIn0) == true  && RECEIVE0 == true) {
    router.valor[0] = mensaje.get(0).floatValue();
  }
  if (mensaje.checkAddrPattern(canalIn1) == true  && RECEIVE1 == true) {
    router.valor[1] = mensaje.get(0).floatValue();
  }
  if (mensaje.checkAddrPattern(canalIn2) == true  && RECEIVE2 == true) {
    router.valor[2] = mensaje.get(0).floatValue();
  }
  if (mensaje.checkAddrPattern(canalIn3) == true  && RECEIVE3 == true) {
    router.valor[3] = mensaje.get(0).floatValue();
  }
  if (mensaje.checkAddrPattern(canalIn0) == true  && RECEIVE4 == true) {
    router.valor[0] = mensaje.get(0).floatValue();
  }
  if (mensaje.checkAddrPattern(canalIn1) == true  && RECEIVE5 == true) {
    router.valor[1] = mensaje.get(0).floatValue();
  }
  if (mensaje.checkAddrPattern(canalIn2) == true  && RECEIVE6 == true) {
    router.valor[2] = mensaje.get(0).floatValue();
  }
  if (mensaje.checkAddrPattern(canalIn3) == true  && RECEIVE7 == true) {
    router.valor[3] = mensaje.get(0).floatValue();
  }
}
