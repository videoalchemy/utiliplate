////////////////////////////////////////////////////
//    RECORDER UTILITY
////////////////////////////////////////
// Snaps screens and saves frames!
// Names files and labels sequences in timestamped directories. 
// Start and stop saveFrame without overwriting previous sequences

///// SETUP: 
// Create symlink 'frames' and 'snaps' from this sketch to: 
//        ln -s /Users/jstephens/Dropbox/_SNAPS/201806-kidsPace/frames ./frames
//        ln -s /Users/jstephens/Dropbox/_SNAPS/201806-kidsPace/snaps ./snaps

///// USAGE: 
//           'r'     --> Start and stop sequence recording
//          'ENTER' --> snap screen


class Recorder {
  boolean  recordIsOn =         false;
  boolean  cursorIsOn =         true;
  String   directoryStartTime = "";

  Recorder () {
  }

  // call this from draw. It will monitor the 'record' toggle switch
  void ready() {
    checkRecordFrame();
  }

  ////////////////////////////////////////////////////////////
  //    SNAP SCREEN
  ////////////////////
  // filename pattern: GLOBAL_VERSION>/<GLOBAL_PROJ>-yyyymmdd-hhmmss-milli-VERSION.tif 
  // eg:               prototype/KidsPace-20180601-132143-3770-prototype.tif
  // destination:      ./snaps --> symlinked to Dropbox/_SNAPS/<project>/snaps      
  // subdirectory:     <PROJ> and <VERSION> are global     
  ////////////////////////////////////////////////////

  // Generates SNAP name and its parent directory
  String nowAsString() {
    return VERSION+"/"+     //immediate parent directory
      PROJ+"-"+             //retain proj name so snaps makes sense individually
      nf(year(), 4)+
      nf(month(), 2)+
      nf(day(), 2)+"-"+
      nf(hour(), 2)+
      nf(minute(), 2)+
      nf(second(), 2)+"-"+
      nf(millis())+"-"+
      VERSION;              //append with version so snaps can be identified in the wild
  }

  // Save the current screen state as a .png in the SNAP_PATH,
  // If you pass a filename, we'll use that, otherwise we'll default to the current date.
  // NOTE: do NOT pass the ".jpg" or the path.
  // Returns the name of the file saved.
  String snapScreen() {
    return snapScreen(null);
  }
  String snapScreen(String fileName) {
    if (fileName == null) {
      fileName = nowAsString();
    }

    // Check for cursor first, turn off if necessary
    // If toggle is on, then cursor should flip back at next animation cycle
    if (cursorIsOn) {
      toggleCursor();
      save(SNAP_PATH + fileName);
      println("SAVED AS "+fileName);
      toggleCursor();
    } else {
      save(SNAP_PATH + fileName);
      println("SAVED AS "+fileName);
    } 
    return fileName;
  }
  //   END SCREEN SNAPS
  ////////////////////////////////////////////////////////////


  ////////////////////////////////////////////////////////////
  //    RECORD FRAMES
  ////////////////////
  // filename pattern: version/yyyymmdd-hr/yyyymmdd-hrmm-######.tiff 
  //  * this divides directory by hours, but within each hour, each frame is marked by minutes
  //  * this avoids having frame 000001 rewritten if frame recording restarts within 60 seconds
  // destination:      kidsPace/frames --> symlinked to Dropbox/_SNAPS/201806-kidsPace/frames      
  // symlink command:
  //        ln -s /Users/jstephens/Dropbox/_SNAPS/201806-kidsPace/snaps ./snaps
  // subdirectory:     
  //        in 'snaps/<version>' (determined by global VERSION)
  ////////////////////////////////////////////////////

  // Generate the name and parent directories of each frame in the sequence
  String frameAsString() {
    return VERSION+
      "/"+
      nf(year(), 4)+
      nf(month(), 2)+
      nf(day(), 2)+
      "-"+
      nf(hour(), 2)+
      nf(minute(), 2)+
      "/"+
      nf(year(), 4)+
      nf(month(), 2)+
      nf(day(), 2)+
      "-"+
      nf(hour(), 2)+
      nf(minute(), 2)+ 
      nf(second(), 2)+
      "-";
  }

  // If you pass a filename, we'll use that, otherwise we'll default to the current date.
  // NOTE: do NOT pass the ".jpg" or the path.
  // Returns the name of the file saved.
  // These act as switch to determine if a name was passed
  String recordFrame() {
    return recordFrame(null);
  }
  String recordFrame(String frameName) {
    if (frameName == null) {
      frameName = frameAsString();
    }
    // unlike snapScreen, saveFrame is called in the utility function checkRecordFrame
    println("RETURNED NAME: "+frameName);
    return frameName;
  }

  //////////////////////////////////////////////////
  //  TOGGLE RECORDING  =  'r'
  void toggleRecording () {
    // Set parent directory for each sequence. Stops from overwriting 
    directoryStartTime = frameAsString();

    // Toggle the switch
    recordIsOn = !recordIsOn;

    println("****************************");
    println("*** Recording = " + recordIsOn + " ***");
    if (recordIsOn) {
      println ("sequence located here: " + FRAME_PATH + directoryStartTime);
    }
    println("****************************" + "\n");
  }
  //  END: TOGGLE RECORDING
  //////////////////////////////////////////////////

  //////////////////////////////////////////////////
  //  CHECK THEN RECORD FRAMES  (use 'r' to toggle Recording)
  // called in draw for ongoing process
  void checkRecordFrame() {
    if (recordIsOn) {
      saveFrame(FRAME_PATH + directoryStartTime + "######.tif");
    }
  }
  //  END: CHECK THEN RECORD FRAMES
  //////////////////////////////////////////////////

 
  //  END: RECORD FRAMES
  ////////////////////////////////////////////////////////////
}
