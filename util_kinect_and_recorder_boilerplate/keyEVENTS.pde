//////////////////////////////
// KeyEVENTS - flipping switches!
//   and mouseEvents too


void mousePressed() {
}

////////////////////////////////////////////////////
//  KEYCODE FOR EVENTS

//////////////////////////////////////
//  CREATE MOMENTARY SWITCH 
// Current keyCode for the pressed key

//   The system variable 'key' always contains the value 
//     of the most recent key on the keyboard (either pressed or released). 

//   For non-ASCII keys, use the 'keyCode' variable. 
//      The keys included in the ASCII specification 
//      (BACKSPACE, TAB, ENTER, RETURN, ESC, and DELETE) 
//      do not require checking to see if the key is coded, 
//      and you should simply use the 'key' variable instead of 'keyCode'

char currentKey; 
int currentKeyCode = -1;

// Remember the current key when it goes down.
void keyPressed() {
  currentKeyCode = keyCode; 
  currentKey = key;

  //DEBUG: 
  println("keyCode = "+keyCode+ " key = "+key);

  //////////////////////////////////////////////////
  //  SNAP SCREEN  =  ENTER
  /////////////////////////////////////////////////
  if (currentKeyCode==ENTER) {
    recorder.snapScreen();
  }

  /////////////////////////////////////////////////
  //  CLEAR BACKGROUND = TAB 
  /////////////////////////////////////////////////
  if (currentKeyCode==TAB) {
    background(0);
    clear(); // this needs specific pgraphic
    // or use this utility function which takes a PGraphic argument
    //makePixelsClearAgain(makePixelsClearForThisPGraphic);
  } 

  if (key == CODED) {
    print("-->Translated: ");
    if (keyCode == LEFT) {
      println("keyCode == LEFT");
    } else if (keyCode == RIGHT) {
      println("keyCode == RIGHT");
    } else if (keyCode == UP) {
      println("keyCode == UP");
    } else if (keyCode == DOWN) {
      println("keyCode == DOWN");
    } else if (key == 'a') {
      kinect.minDepth = constrain(kinect.minDepth+10, 0, kinect.maxDepth);
    } else if (key == 's') {
      kinect.minDepth = constrain(kinect.minDepth-10, 0, kinect.maxDepth);
    } else if (key == 'z') {
      kinect.maxDepth = constrain(kinect.maxDepth+10, kinect.minDepth, 2047);
    } else if (key =='x') {
      kinect.maxDepth = constrain(kinect.maxDepth-10, kinect.minDepth, 2047);
    }
  }

  // Handle standard keys as a switch
  switch(currentKey) {

  case 'r':
    //////////////////////////////////////////////////
    //  TOGGLE SCREEN RECORDING  =  'r'
    //toggleRecording();
    recorder.toggleRecording();
    break;

  case 'c':
    //////////////////////////////////////////////////
    //  TOGGLE CURSOR  =  'c'
    toggleCursor();
    break;

  case '-':
    println("HYPEN!");
    break;
  case '1':
    println("1");
    break;
  case '2':
    println("2");
    break;
  case '3':
    println("3");
    break;
  case '4':
    println("4");
    break;
  case '5':
    println("5");
    break;
  case '6':
    println("6");
    break;
  case '7':
    println("7");
    break;
  case '8':
    println("8");
    break;
  case '9':
    println("9");
    break;
  case '0':
    println("10");
    break;
  }
}


// Clear the current key when it goes up.
void keyReleased() {
  currentKeyCode = -1;
}
//  END MOMENTARY SWITCH  
//////////////////////////////////////

//////////////////////////////////////
//  EXECUTE MOMENTARY SWITCHES
// This function shuts down on key release and runs only if a key is pressssssed 
void updateControlsFromKeyboard() {
  // if no key is currently down, make sure all of the buttons are up and bail  
  if (currentKeyCode == -1) {
    //clearButtons();
    return;
  }


  /////////////////////////////////////////////////
  //     REPEATING BUTTON: (good for selecting source images) 
  /////////////////////////////////////////////////
  //NOTE: THESE ARE NOT DEBOUNCED! Expect repeating keys here!!!
  if (currentKey == 'q') {
    println(currentKey);
  } else if (currentKey == 'w') {
    println(currentKey);
  } else if (currentKey == 'e') {
    println(currentKey);
  } else if (currentKey == 't') {
    println(currentKey);
  } else if (currentKey == 'y') {
    println(currentKey);
  } else if (currentKey == 'u') {
    println(currentKey);
  } else if (currentKey == 'i') {
    println(currentKey);
  } else if (currentKey == 'o') {
    println(currentKey);
  } else if (currentKey == 'p') {
    println(currentKey);
  } else if (currentKey == '[') {
    println(currentKey);
  } else if (currentKey == ']') {
    println(currentKey);
  }

  //     END MOMENTARY SWITCH
  ////////////////////////////////////////////////
}
//  END KEYCODE FOR EVENTS
/////////////////////////////////////////////////////////////
