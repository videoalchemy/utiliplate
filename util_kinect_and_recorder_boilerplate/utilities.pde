////////////////////////////////////
// UTILITY FUNCTIONS
////////////////////////////////////

//////////////////////////////////////////////////
//  TOGGLE CURSOR  =  'c'
void toggleCursor () {
  cursorIsOn = !cursorIsOn;    
  println("*** Cursor is " + cursorIsOn + " ***");
  if (cursorIsOn) {
    cursor();
  } else {
    noCursor();
  }
}
//  END: TOGGLE CURSOR
//////////////////////////////////////////////////

//////////////////////////////////////////////////
//  MAKE PIXELS CLEAR FOR PGRAPHIC  =  'TAB'
void makePixelsClearAgain(PGraphics p) {
    p.beginDraw();
    p.clear();
    p.endDraw();
}
//  END: MAKE PIXELS CLEAR
//////////////////////////////////////////////////

//////////////////////////////////////////////////
//   PROVIDE SOME POINTERS
void printInstructions() {
  println("");
  println("                 Keyboard controls");
    println("          -----------------------------------");
     println("   ENTER  takes a snapshot and saves it to "+SNAP_PATH);
     println("   TAB     clears pgraphic background to transparent");
     println("   'r'     toggle screen recording");
     println("   'c'     toggle cursor");
     println("   'a,s'     minDepth");
     println("   'z,x'     maxDepth");
     println("   'q'     momentary switch, stays engaged until released");
     println("   'w'     momentary switch, stays engaged until released");
     println("   '-'     ");

     println("          -----------------------------------");
     println("");
}
//////////////////////////////////////////////////
