/* jstephens  201806
 Boilerplate for Kinect projects
 with recoredFrame 'r' and snapScreen 'ENTER' functionality in Recorder class
 */

import org.openkinect.freenect.*;
import org.openkinect.processing.*;

////////////////////////////////////////////////////////////
///// GLOBALS REQUIRED BY Recorder class
String PROJ       = "test_frame_location";                        
String VERSION    = "prototype";                                  
String SNAP_PATH  = ("./snaps/");   //("../../../snaps/");        
String FRAME_PATH = ("./frames/"); //("../../../frames/");     
////////////////////////////////////////////////////////////

// Kinect helper
Kinecter kinect;

// Record and snap
Recorder recorder;

boolean cursorIsOn = true;



void setup() {
  size(1280, 480, P2D);

  kinect = new Kinecter(this);
  recorder = new Recorder();
  printInstructions();
}

void draw() {

  ////// util
  // Start/stop recording frames if 'r'
  recorder.ready();
  // Check for button presses
  //updateControlsFromKeyboard();

  
  // Kinect
  // Draw the Generic depth image
  kinect.drawDepthImage(); 

  // Draw the greyscale image that's based on the depthArray
  image(kinect.getRawDepthImage(), 640, 0);

  // Show the calibration info (angle and distance)
  kinect.displayDistanceAndAngle();
}
