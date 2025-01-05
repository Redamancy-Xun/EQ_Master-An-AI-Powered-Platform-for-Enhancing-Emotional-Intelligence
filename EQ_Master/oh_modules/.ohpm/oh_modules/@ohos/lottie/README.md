# lottie

## Introduction

Lottie is an animation library for OpenHarmony that parses Adobe After Effects animations, exported as JSON files with Bodymovin, and renders them natively on mobile devices.

![showlottie](./screenshot/showlottie_EN.gif)


## How to Install

```
 ohpm install @ohos/lottie
```
For details about the OpenHarmony ohpm environment configuration, see [OpenHarmony HAR](https://gitee.com/openharmony-tpc/docs/blob/master/OpenHarmony_har_usage.en.md).

## Example
### Example
```
import lottie, { AnimationItem } from '@ohos/lottie';

@Entry
@Component
struct Index {
  // Build a rendering context.
  private renderingSettings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasRenderingContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.renderingSettings)
  private animateItem: AnimationItem | null = null;
  private animateName: string = "animation"; // name

  // Destroy the animation.
  aboutToDisappear(): void {
    console.info('aboutToDisappear');
    lottie.destroy();
  }

  build() {
    Row() {
      // Configure a canvas.
      Canvas(this.canvasRenderingContext)
        .width(200)
        .height(200)
        .backgroundColor(Color.Gray)
        .onReady(() => {
          // Load the animation.
          if (this.animateItem != null) {
            // Load animations during canvas onReady, ensure that the animation size is correct.
            this.animateItem?.resize();
          } else {
            // Anti-aliasing settings.
            this.canvasRenderingContext.imageSmoothingEnabled = true;
            this.canvasRenderingContext.imageSmoothingQuality = 'medium'
            this.loadAnimation();
          }
        })
    }
  }

  loadAnimation() {
    this.animateItem = lottie.loadAnimation({
      container: this.canvasRenderingContext,
      renderer: 'canvas', // canvas renderer
      loop: true,
      autoplay: false,
      name: this.animateName,
      contentMode: 'Contain',
      path: "common/animation.json",
    })
    // Animations are loaded asynchronously, any operations on animateItem should be performed within the callback function for when the animation has finished loading.
    this.animateItem.addEventListener('DOMLoaded', (args: Object): void => {
      this.animateItem.changeColor([225, 25, 100, 1]);
      this.animateItem.play()
    });
  }

  destroy() {
    this.animateItem.removeEventListener("DOMLoaded");
    lottie.destroy(this.animateName);
    this.animateItem = null;
  }
}

```
### Important Notes
- 1. It is recommended to load the animation in the onReady method of canvas, and call the lottie.destroy(name) method before loading the animation to ensure that the animation will not be loaded repeatedly.
- 2. It is recommended to put the operation of the animation animateItem in the 'DOMLoaded' callback listener of addEventListener, and ensure that the animation-related operations are performed after the complete construction and parsing are completed, so as to avoid potential loading order problems. Because if it is the same code block, the animation is loaded asynchronously.
- 3. It is recommended to add animation anti-aliasing, such as the sample code code 67 to 68 line, to reduce the jagged phenomenon of the animation edge, make the animation screen smoother and more delicate, and achieve the best animation effect.
- 4. For the destruction of animation, it is recommended to use the lottie.destroy(name) method, which is more performance-friendly than directly using animateItem.destroy().
- 5. It is recommended to destroy all animations on the page when the page is destroyed or uninstalled to ensure that the page resources are properly managed and released.
- 6. If the obfuscation mode compilation fails, it is recommended to add the configuration in the obfuscation-rules.txt file under the corresponding module: -keep ./oh_modules/@ohos/lottie.
- 7. It is recommended that the aspect ratio of the canvas be consistent with that of the animation. For example, if the aspect ratio of the animation is 1000 * 2000 (i.e., a ratio of 1:2), then the width and height of the canvas can be set to 200 * 400, also maintaining a ratio of 1:2. It is recommended that the width and height of the canvas should not be larger than the original width and height of the animation.
- 8. Note: When loading external resource images, if the specified path is used: imagePage:'lottie/images/', the path of the external resource image refers to the path under the rawfile directory or the file directory in the sandbox.
- 9. The external image resources referenced in Lottie's JSON file need to be stored in the rawfile directory. For example, if "u":"images/" in the json file, a folder named images is created in the rawfile directory to store the images.


## How to Use

### To start off, get required data prepared.

Lottie animations are created in Adobe After Effects and exported with Bodymovin as JSON files.

When creating an animation in Adobe After Effects, you need to set the animation width (**w**), animation height (**h**), bodymovin version (**v**), frame rate (**fr**), start frame (**ip**),
end frame (**op**), static resource information (**assets**), and layer information (**layers**).

For demo test purposes, you can use the [JSON file in the example project](https://gitee.com/openharmony-tpc/lottie/tree/master/entry/src/main/ets/common/lottie).

### 1. Import the component to the corresponding class.

   ```
   import lottie from '@ohos/lottie'
   ```

### 2. Build a rendering context.

   ```
     private mainRenderingSettings: RenderingContextSettings = new RenderingContextSettings(true)
     private mainCanvasRenderingContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.mainRenderingSettings)
   ```

### 3. Place the JSON file required by the animation in the directory at the same level as the **pages** directory and reference the file. (In this example, the JSON file used is **entry/src/main/ets/common/lottie/data.json**.)

   Note: The JSON file path cannot be a relative path, such as one that starts with a single dot (.) or double dot (..), followed by a slash (/). Using a relative path will result in a failure to fetch the animation source.

   This is because a relative path referenced in the **index** page is based on the **index.ets** file, whereas the path passed to the **loadAnimation** API is based on the **pages** folder.

   Therefore, if the JSON file is stored in the **pages** folder, the path should be **pages/common/data.json**.

   ```
     private path:string = "common/lottie/data.json"
     Or
     private jsonData:string = {"v":"4.6.6","fr":24,"ip":0,"op":72,"w":1000,"h":1000,"nm":"Comp 2","ddd":0,"assets":[],...}
   ```

### 4. Configure a canvas.

   ```
          Canvas(this.mainCanvasRenderingContext)
           .width('50%')
           .height(360 + 'px')
           .backgroundColor(Color.Gray)
           .onReady(()=>{
           // Anti-aliasing settings.
               this.mainCanvasRenderingContext.imageSmoothingEnabled = true;
               this.mainCanvasRenderingContext.imageSmoothingQuality = 'medium'
           })
   ```

   Note: It is recommended that the aspect ratio set for the canvas be the same as that of the JSON animation resource. For example, if the aspect ratio of the JSON animation resource is 1:2, the aspect ratio set for the canvas should also be 1:2.
   
   The anti-aliasing settings in this example: **mainCanvasRenderingContext.imageSmoothingEnabled = true** and **mainCanvasRenderingContext.imageSmoothingQuality = 'medium'**
   
   A canvas is cleared before an animation is drawn on it.

### 5. Load the animation.

   Pay attention to the time when you want your animation to load. If you want the animation to load upon a button click, simply place the animation loading logic in the click event. If you want the animation to load automatically once the page where it is located is displayed, you must place the animation loading logic within or after the **onReady()** lifecycle callback.

   For a canvas to load one animation multiple times or load different animations, manually destroy the previously loaded animation (by calling **lottie.destroy('name')**) each time before the canvas loads again.

     ```      
         lottie.destroy('2016'); // Destroy the previously loaded animation before loading a new one.
         this.animationItem = lottie.loadAnimation({
                 container: this.mainCanvasRenderingContext,  // Rendering context.
                 renderer: 'canvas',                          // Rendering mode.
                 loop: true,                                  // Whether to loop the playback. The default value is true.
                 autoplay: true,                              // Whether to enable automatic playback. The default value is true.
                 name: '2016',                                // Animation name.
                 contentMode: 'Contain',                      // Fill mode.
                 frameRate: 30,                               // Set the frame rate to 30.
                 imagePath: 'lottie/images/',                 // Load and read images in the specified path.
                 path: this.path,                             // JSON file path.
                 initialSegment: [10,50]                      // Initial segment of the animation.
               })
          Or     
         lottie.loadAnimation({
                 container: this.mainCanvasRenderingContext,  // Rendering context.
                 renderer: 'canvas',                          // Rendering mode.
                 loop: true,                                  // Whether to loop the playback. The default value is true.
                 autoplay: true,                              // Whether to enable automatic playback. The default value is true.
                 contentMode: 'Contain',                      // Fill mode.
                 frameRate: 30,                               // Set the frame rate to 30.
                 animationData: this.jsonData,                // JSON object data.
                 initialSegment: [10,50]                      // Initial segment of the animation.
               })
          Or
         lottie.loadAnimation({
                 uri: "https: // assets7.lottiefiles.com/packages/lf20_sF7uci.json", // Internet resources specified by URI.
                 container: this.canvasRenderingContext,                            // Rendering context.
                 renderer: 'canvas',                                                // Canvas rendering mode.
                 loop: true,                                                        // Whether to loop the playback. The default value is true.
                 autoplay: true,                                                    // Whether to enable automatic playback. The default value is true.
                 name: this.animateName,                                            // Animation name.
               })
     ```

   To load an animation, use either **path** or **animationData**.

   - **path**: Only relative paths under **entry/src/main/ets** are allowed. Cross-package file search is not supported.
   - **animationData**: Set this parameter based on **ResourceManager**.
   - **uri**: Internet animations can be loaded through URIs. In this case, you must request the permissions **ohos.permission.INTERNET** and **ohos.permission.GET_NETWORK_INFO**.
   - Loading external resource images: By default, the application reads images in the sandbox path. If the specified images are not found in the sandbox, the application searches for them in **rawfile**.

### 6. Load an animation with an HSP.

   To load an animation with an HSP, pass in the **context** parameter to the **loadAnimation** API. This parameter is optional and not required where no HSP is involved.

   ```   
       let contexts = getContext(this).createModuleContext('library') as common.UIAbilityContext;
       lottie.loadAnimation({
               container: this.mainCanvasRenderingContext,  // Rendering context.
               renderer: 'canvas',                          // Rendering mode.
               loop: true,                                  // Whether to loop the playback. The default value is true.
               autoplay: true,                              // Whether to enable automatic playback. The default value is true.
               animationData: this.jsonData,                // JSON object data.
               context: contexts,                           // Current context.
               contentMode: 'Contain',                      // Fill mode.
               initialSegment: [10,50]                      // Initial segment of the animation.
             })
   ```

   When an HSP is involved, lottie loads the JSON resource file through **animationData**. As such, you must place the JSON resource file in **rawfile**.

   To load an animation, use **animationData**.

   **animationData**: Set this parameter based on **ResourceManager**.

   ```   
       let resStr = new util.TextDecoder('utf-8',{ignoreBOM: true});
       let context = getContext(this).createModuleContext('library') as common.UIAbilityContext
       context.resourceManager.getRawFile('grunt.json',(err: Error,data: Uint8Array) =>{
         if(data === null || data === undefined || data.buffer=== undefined){
           return;
         }
         let lottieStr = resStr.decode(new Uint8Array(data.buffer));
         this.jsonData = JSON.parse(lottieStr);
       })
   ```

### 7. Control animation playback.

- Play the animation.

  ```
  lottie.play() // Play all animations.
  Or
  animationItem.play() // Play a given animation.
  ```

- Stop the animation.

  ```
  lottie.stop() // Stop all animations.
  Or
  animationItem.stop() // Stop a given animation.
  ```

- Pause the animation.

  ```
  lottie.pause() // Pause all animations.
  Or
  animationItem.pause() // Pause a given animation.
  ```

- Switch the animation playback state between running and paused.

  ```
  lottie.togglePause() // Switch the playback state between running and paused for all animations.
  Or
  animationItem.togglePause() // Switch the playback state between running and paused for a given animation.
  ```

- Set the playback speed.
  > Note: If the speed is greater than **0**, the animation plays forwards. If the speed is less than **0**, the animation plays backwards. If the speed is **0**, the animation is paused. If the speed is **1.0** or **-1.0**, the animation plays at the normal speed.

  ```
  lottie.setSpeed(1) // Set the playback speed for all animations.
  Or
  animationItem.setSpeed(1) // Set the playback speed for a given animation.
  ```

- Set the playback direction.
  > Note: The value **1** indicates forward, and **-1** indicates backward.

  ```
  lottie.setDirection(1) // Set the playback direction for all animations.
  Or
  animationItem.setDirection(1) // Set the playback direction for a given animation.
  ```

- Destroy the animation.
  > Note: An animation needs to be destroyed when the page where it is located disappears or exits. The **destroy()** API can be used together with the **aboutToDisappear()** and **onPageHide()** callbacks of the page or the **onDisAppear()** callback of the canvas component.

  ```
  lottie.destroy() // Destroy all animations.
  Or
  lottie.destroy('name') // Destroy a given animation.
  ```

- Clear Cache
  ```
  lottie.clearFileCache() //Clear all animation caches
  Or
  lottie.clearFileCache('path') //Clear the specified animation cache
  Or
  lottie.clearFileCache('path',container) //Clear the network resource cache in the specified local animation
  ```

- Stop the animation at a frame or a point of time.
  > Note: The second parameter specifies whether to control by frame or time (in milliseconds). The value **true** means to control by frame, and **false** (default) means to control by time.

  ```
  animationItem.goToAndStop(250,true)
  Or
  animationItem.goToAndStop(5000,false)
  ```

- Start the animation from a frame or a point of time.
  > Note: The second parameter specifies whether to control by frame or time (in milliseconds). The value **true** means to control by frame, and **false** (default) means to control by time.
  ```
  animationItem.goToAndPlay(250,true)
  Or
  animationItem.goToAndPlay(12000,false)
  ```

- Set an animation segment to limit the frame range for animation playback.

  ```
  animationItem.setSegment(5,15);
  ```

- Play animation segments.
  > Note: The second parameter specifies whether the setting takes effect immediately. The value **true** indicates the setting takes effect immediately, and **false** indicates that the setting takes effect upon the next playback.

  ```
  animationItem.playSegments([5,15],[20,30],true)
  ```

- Reset animation segments so that the animation plays from the start frame.
  > Note: The parameter specifies whether the setting takes effect immediately. The value **true** indicates the setting takes effect immediately, and **false** indicates that the setting takes effect upon the next playback.

  ```
  animationItem.resetSegments(5,15);
  ```

- Obtain the animation duration or number of frames.
  > Note: The value **true** means to obtain the number of frames, and **false** means to obtain the duration (in ms).

  ```
  animationItem.getDuration();
  ```

- Add an event listener.
  > Note: For an event listener to be removed correctly, its callback function must be the same as that of the event listener already added and must be predefined.

  ```
  AnimationEventName = 'enterFrame' | 'loopComplete' | 'complete' | 'segmentStart' | 'destroy' | 'config_ready' | 'data_ready' | 'DOMLoaded' | 'error' | 'data_failed' | 'loaded_images';
  
  animationItem.addEventListener("enterFrame",function(){
      // TODO something
  })
  ```

- Change the animation color.

  > Note: The first parameter indicates the RGB color value. The second parameter indicates the animation layer and is optional. The third parameter indicates the index of the element corresponding to the animation layer and is optional.

  ```
  animationItem.changeColor([255,150,203])  // Change the color of the entire animation.
  Or
  animationItem.changeColor([255,150,203],2) // Change the color of the second layer of the animation.
  Or
  animationItem.changeColor([255,150,203],2,2) // Change the color of the second element at the second layer of the animation.
  ```

- Remove an event listener.

  ```
  animationItem.removeEventListener("enterFrame",function(){
      // TODO something
  })
  ```

- Resize the animation layout.

  ```
  animationItem.resize()
  ```

- Set the animation fill mode.

  > Note: There are five fill modes: **Fill**, **Cover**, **Top**, **Bottom**, and **Contain**. The default mode is **Contain**.

  ```
  animationItem.setContentMode('Cover');
  
  ```

- Set the frame rate range of the animation.

  > Note: The frame rate ranges from 1 to 120. A larger frame rate causes higher power consumption.

  ```
  animationItem.setFrameRate(30);
  
  ```

- Clear cache file
  > Note: the container is with canvas component binding context CanvasRenderingContext2D, json file path for local resources
  ```
  lottie.clearFileCache() //Clear all animation cache files
  Or
  lottie.clearFileCache('path') //Clear the specified animation cache file
  Or
  lottie.clearFileCache('path',container) //Clears the network resource cache file in the specified local animation
  ```

### 8. Destroy the animation.

   Generally, the animation is destroyed in the **onDisAppear()** API of the canvas component or in the **aboutToDisappear()** method during page destruction.

   With lottie, you can destroy an animation in two modes:

    - **lottie.destroy**: destroys all animations; **lottie.destroy(name)** destroys the animation with the specified name. You are advised to use this mode to destroy animations.
    - **animationItem.destroy**: destroys a given animation. Improper use may cause memory leakage. To destroy a given animation, you are advised to use **lottie.destroy(name)**.<br>

   > Note 1: When there are multiple animations on one page and the animation instance is assigned to the same variable **animationItem**, only the last animation is destroyed when **animationItem.destroy** is called. In the following code example, the animations whose names are **cat** and **2016** are assigned to **this.animationItem**. Calling **animationItem.destroy()** destroys only the animation whose name is **2016**, but not the one whose name is **cat**.
   
     ```
         this.animationItem = lottie.loadAnimation({
               container: this.mainCanvasRenderingContext,  // Rendering context.
               renderer: 'canvas',                          // Rendering mode.
               loop: true,                                  // Whether to loop the playback. The default value is true.
               autoplay: true,                              // Whether to enable automatic playback. The default value is true.
               name: 'cat',                                // Animation name.
               contentMode: 'Contain',                      // Fill mode.
               path: this.path,                             // JSON file path.
               initialSegment: [10,50]                      // Initial segment of the animation.
             })
             
         this.animationItem = lottie.loadAnimation({
               container: this.mainCanvasRenderingContext,  // Rendering context.
               renderer: 'canvas',                          // Rendering mode.
               loop: true,                                  // Whether to loop the playback. The default value is true.
               autoplay: true,                              // Whether to enable automatic playback. The default value is true.
               name: '2016',                                // Animation name.
               contentMode: 'Contain',                      // Fill mode.
               path: this.path,                             // JSON file path.
               initialSegment: [10,50]                      // Initial segment of the animation.
             })        
     
     ```

   > Note 2: If you call the following APIs in the same code block as **lottie.loadAnimation** before animation loading is complete, the settings may not take effect: **stop**, **togglePause**, **pause**, **goToAndStop**, **goToAndPlay**, **setSegment**, **getDuration**, **changeColor**, and **setContentMode**. <b>Call these APIs after the animation is loaded. You can use **animationItem.addEventListener('DOMLoaded') **to listen for the animation loading completion.</b>
   
   ```
   // The animation is not completely loaded. The settings of changeColor and setContentMode are invalid.
   Button('Load 2016')
       .onClick(() => {
         if (this.animationItem2 == null) {
           this.animationItem2 = lottie.loadAnimation({
             container: this.canvasRenderingContext,
             renderer: 'canvas', // Canvas rendering mode.
             name: '2016',
             path: "common/lottie/data.json", 
           })
           this.animationItem2.changeColor([255, 203]);
           this.animationItem2.setContentMode('Top');
         }
       })
           
   ```
   
   ```
   // After animationItem.addEventListener('DOMLoaded') is invoked, the settings of changeColor and setContentMode are valid.
   Button('Load 2016')
     .onClick(() => {
       if (this.animationItem2 == null) {
         this.animationItem2 = lottie.loadAnimation({
           container: this.canvasRenderingContext,
           renderer: 'canvas', // Canvas rendering mode.
           loop: true,
           autoplay: false,
           name: '2016',
           contentMode: 'Contain',
           path: "common/lottie/data.json",
         })
     
         this.animationItem2.addEventListener('DOMLoaded', (args: Object): void => {
           this.animationItem2.changeColor([255, 203]);
           // this.animationItem2.setContentMode('Top');
           // ...
         }); // The event is triggered after the animation is loaded but before it is played.
       }
     })
   
   ```

### 9. Confuse
- Confusion leads to compilation errors. Please configure the following in the obfusion-rules.txt file under the corresponding module: - kernel/ Oh_modules/@ ohos/lottie, this solves the error caused by obfuscation compilation

### 10. Determine whether the animation resource is a network load example
```
 this.isNet = 'Whether to load the network' + this.animateItem.isNetLoad
```

## Available APIs


| API                 | Type                     | Description                                                              |
|-----------------------|--------------------------|--------------------------------------------------------------------------|
| play()                | name?                    | Plays the animation.                                                     |
| stop()                | name?                    | Stops the animation.                                                     |
| pause()               | name?                    | Pauses the animation.                                                    |
| togglePause()         | name?                    | Switches the animation playback state between running and paused.        |
| destroy()             | name?                    | Destroys the animation.                                                  |
| goToAndStop()         | value, isFrame?, name?   | Seeks to a certain frame or point of time and then stops the animation.  |
| goToAndPlay()         | value, isFrame?, name?   | Seeks to a certain frame or point of time and then starts the animation. |
| setSegment()          | init,end                 | Sets an animation segment.                                               |
| playSegments()        | arr, forceFlag           | Plays animation segments.                                                |
| resetSegments()       | forceFlag                | Resets the animation.                                                    |
| setSpeed()            | speed                    | Sets the playback speed.                                                 |
| setDirection()        | direction                | Sets the playback direction.                                             |
| getDuration()         | isFrames?                | Obtains the animation duration.                                          |
| addEventListener()    | eventName,callback       | Adds an event listener.                                                  |
| removeEventListener() | name,callback?           | Removes an event listener.                                               |
| changeColor()         | color, layer?, index?    | Changes the animation color.                                             |
| setContentMode()      | contentMode              | Sets the fill mode.                                                      |
| setFrameRate()        | frameRate                | Sets the animation frame rate.                                           |
| clearFileCache()      | url?, container?         | Clear cache file                                                         |

## New Features
1. The animation color can be changed in canvas rendering mode.
- The color value can be in RGB format.
- The color value can be in RGBA format.
- The color can be set for the start keyframe.

2. Certain masks and mattes features are supported for canvas rendering.
- For masks, the supported modes are: mode = a, mode = s, mode = f.
- For mattes, the supported modes are: tt = 1, tt = 2.

3. The Gaussian blur effect is added for animations in canvas rendering mode.

4. External resource images can be loaded in canvas rendering mode.
- External resource images in the sandbox (which is searched before the **rawfile** folder) can be loaded.
- External resource images in the **rawfile** folder can be loaded.

5. The fill mode can be set, with the following options available:
- Fill (may be stretched, not cropped)
- Top (aligned with the top edge, not cropped)
- Bottom (aligned with the bottom edge, not cropped)
- Cover (may be cropped)
- Contain (aligned with the center vertically, may be cropped)

6. The frame rate can be set for animations.

7. Internet animations and animations specified by URIs can be loaded.
- Animations in the path specified by URIs can be rendered.
- Internet animation can be rendered.
- Note: If the animation file contains Internet resources, you must request the permissions **ohos.permission.INTERNET** and **ohos.permission.GET_NETWORK_INFO**.

8. When the animation is completely invisible, the current animation will automatically pause and stop sending drawing instructions to optimize performance and reduce power consumption.

## Constraints

This project has been verified in the following version:
- DevEco Studio: NEXT Developer Beta3 (5.0.3.524), SDK: API 12 (5.0.0.25)
- DevEco Studio: NEXT Developer Beta1 (5.0.3.122), SDK: API 12 (5.0.0.18)

## Directory Structure

````
/lottie        # Root directory of the project
├── entry      # Sample code
├── library    # Lottie library folder
│    └─ src/main/js    # Core code, including JSON parsing, animation drawing, and animation manipulation
│          └─ 3rd_party    
│          └─ animation    
│          └─ effects      
│          └─ elements      
│          └─ modules
│          └─ renderers    
│          └─ utils
│          └─ EffectsManager.js  
│          └─ main.js
│          └─ mask.js
│       └─index.d.ts    # API declaration                     
├── README.md     # Readme   
├── README_zh.md  # Readme                 
````

## How to Contribute

If you find any problem when using lottie, submit an [issue](https://gitee.com/openharmony-tpc/lottie/issues) or a [PR](https://gitee.com/openharmony-tpc/lottie/pulls).

## License

This project is licensed under [MIT License](https://gitee.com/openharmony-tpc/lottie/blob/master/LICENSE).

## Features Not Yet Supported

* HTML rendering mode
* Filter effect in SVG rendering
* Some masks and mattes features
* Luminance mask (that is, tt = 3)
* Animation visibility control in components
* Animation registration
* Animation search
* Animation data update
* Certain effects
* Animations containing expressions
