# Code Review — Utiliplate

**Reviewed:** 2026-03-01
**Reviewer:** Claude (claude-sonnet-4-6)
**Branch:** claude/code-review-feedback-C4p6D

---

## Overall Assessment

Utiliplate is a Processing boilerplate for frame recording, screen snapshots, and
Kinect sensor integration in creative coding workflows. The intent is clear and the
motivation is legitimate — the recording/archiving problem in live generative art
is real, and building a reusable template to solve it once is the right instinct.

This reads as the work of someone with deep hands-on creative coding experience who
understands the domain problem well but is still developing software engineering
fundamentals. The code solves real problems but shows classic signs of solo
creative-coder development: works in isolation, pragmatic shortcuts, and no safety nets.

**Verdict:** Strong practitioner, developing engineer.

---

## Scorecard

| Dimension          | Score    | Notes                                                          |
|--------------------|----------|----------------------------------------------------------------|
| Domain knowledge   | Strong   | Clearly knows the creative coding workflow deeply              |
| Problem definition | Strong   | The problem is real and well scoped                            |
| Architecture       | Moderate | Good instincts, some structural gaps                           |
| Code quality       | Moderate | Clean where implemented, many stubs and debugging artifacts    |
| Error handling     | Weak     | Silent failures on file I/O are dangerous for a recorder       |
| Testing            | None     | A significant gap for a template project                       |
| Documentation      | Adequate | README communicates intent, lacks depth                        |
| Maintenance        | Weak     | Dormant, dead code, no archived/status signal                  |
| Git hygiene        | Good     | Commits are meaningful, message quality is decent              |

---

## What Was Done Well

### 1. Solved a Real Problem
The frame recorder works. The timestamped directory structure
(`VERSION/YYYYMMDD-HH/YYYYMMDD-HHMMSS-######.tif`) is thoughtful — it organizes
output by version and time, prevents collisions, and makes post-processing easier.
This is not beginner thinking.

### 2. Modular File Organization
Splitting into `Recorder.pde`, `keyEVENTS.pde`, `utilities.pde` correctly uses
Processing's multi-tab sketch paradigm for separation of concerns instead of
dumping everything into one file.

### 3. Configuration at the Top
Having `PROJ`, `VERSION`, `SNAP_PATH`, and `FRAME_PATH` as globals at the top of
the main file creates a clear "configure here" contract for users of the template.

### 4. Recorder Class Design
Encapsulating recording state in a `Recorder` class rather than spreading state
through globals is architecturally correct. The toggle pattern, the
`checkRecordFrame()` polling method, and the `directoryStartTime` approach all
demonstrate thought-through state machine design.

### 5. Critical Bug Fix
The 2021 commit — *"Silly rabbit, the frame recorder belongs at the BOTTOM of the
draw loop, not the top"* — shows real debugging depth. Recording the previous frame
instead of the current one is a subtle, maddening bug. Finding and fixing it is not
beginner work.

### 6. .gitignore for Output Files
The sketch-level `.gitignore` excluding `.png`, `.tif`, `.jpg`, and `.DS_Store`
shows understanding that output artifacts don't belong in version control.

---

## What Was Amateur

### 1. Dead Code Left in Production State
The most visible sign of incomplete work:

- `Kinecter.pde` is a 1-line empty file
- `utilities/utilities.pde` is completely empty
- All Kinect calls are commented out in the main file
- `updateControlsFromKeyboard()` is called in `draw()` but commented out
- Debugging `println()` statements left scattered in `keyPressed()`

In a boilerplate — meant to be cloned as a starting point — dead stubs and
commented-out code are especially harmful because users cannot distinguish
intentional scaffolding from abandoned work.

### 2. Detached `sketch_path` Folder
`sketch_path/sketch_path.pde` appears to be a copy of a Daniel Shiffman file
system traversal example. It lives in its own folder with no connection to the
rest of the project — not imported, not referenced, not integrated.

### 3. Magic Strings, No Runtime Configuration
```java
String PROJ       = "test_frame_location";
String VERSION    = "prototype";
String SNAP_PATH  = "./snaps/";
String FRAME_PATH = "./frames/";
```
All configuration is hardcoded in source. Every fork requires editing source code
to configure. A `config.json` (loadable via Processing's `loadJSONObject()`) would
decouple configuration from code.

### 4. The `key '0'` Bug
In `keyEVENTS.pde`, the case for the `0` key prints `"10"` instead of `"0"`.
Almost certainly a copy-paste error from the `1-9` case block. Small, but the kind
of thing caught by code review or tests — both of which are absent.

### 5. No Error Handling on File I/O
`Recorder.pde` calls `saveFrame()` and `save()` without any validation:
- No check that `SNAP_PATH` or `FRAME_PATH` exist or can be created
- No catch on write failures
- No fallback if a symlinked directory is absent
- Silent failure means users lose recorded frames with no feedback

For a recording utility, silent data loss is the worst possible failure mode.

### 6. Personal Paths in Documentation
README symlink instructions have leaked personal path context. The template should
use generic placeholder paths (`/path/to/external/storage`) exclusively.

### 7. No Testing, No CI
Zero tests exist. For a template project — the foundation for other work — even
basic smoke tests add confidence when forking and modifying.

### 8. Raw ArrayList Without Generics
```java
// in sketch_path.pde
ArrayList fileList = new ArrayList();  // Java 5 style
```
Modern Processing runs on Java 11+. This should be:
```java
ArrayList<File> fileList = new ArrayList<>();
```

### 9. Three-Year Dormancy Without a Status Signal
Last commit: April 2021. The project is not marked as archived, deprecated, or
"minimum maintenance." Users forking today have no signal about compatibility risk
with newer Processing versions.

---

## Alternative Paths to the Same Goal

### Path 1: Processing Library (`.jar`)
Package `Recorder` and `Kinecter` as an installable Processing library. Users
install via the Processing library manager and call `import utiliplate.*;`. Code
lives in one place; users never touch it. Best for reusability.

### Path 2: GitHub Template Repository
Mark the repo as a GitHub Template Repository (Settings > Template repository).
Users get a clean fork without git history. Zero additional code required — just
a settings toggle plus the cleanup work already listed in the TODO.

### Path 3: Bash Project Generator
The README already describes this as future state. A shell script that scaffolds
a new Processing project with user-supplied `PROJ` and `VERSION` injected into the
source is significantly more useful than a static template to manually edit.

```bash
./new-sketch.sh my_project v1.0
# → creates my_project/ with config pre-populated
```

### Path 4: p5.js Port
The same boilerplate in p5.js reaches a larger audience and gains access to a
proper tooling ecosystem (npm, Jest, GitHub Actions). Frame recording in the browser
uses `CCapture.js` or the `MediaRecorder` API.

### Path 5: openFrameworks / C++
If recording performance is the real constraint (Processing's `saveFrame()` causes
frame drops), openFrameworks with `ofxFastFboReader` provides GPU-accelerated frame
capture. Higher learning curve, but eliminates the bottleneck.

---

## References

- See `TODO.md` for prioritized, actionable items derived from this review.
- Processing `loadJSONObject()` docs: https://processing.org/reference/loadJSONObject_.html
- GitHub Template Repositories: https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-template-repository
- CCapture.js (p5.js recording): https://github.com/spite/ccapture.js
