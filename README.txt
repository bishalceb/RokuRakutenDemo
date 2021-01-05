 Roku Scene Graph channel containing 3 screen HomeScreen,MovieDetailPage and VideoPlayer
Roku app source code structure
.
├── components
│   ├── <scene>.brs
│   └── <scene>.xml
├── source/default/images
│   ├── <icon>.png
│   └── <logo>.png
├── manifest
└── source
    ├── main.brs
    └── <util>.brs
    └──  Apicenter.brs
    
components: In this folder where you put your SceneGraph source code in.
locale/default/images: the folder where you should put images used by your app in.
manifest: the app metadata file.
source: the folder where you put your BrightScript source code including main.brs, the entry point of Roku app, in.
Source/Apicenter:This brs file we can manage APi call and handel it
Source/util: Required app information exist in this file



The project
The code
The tree below should give you an idea on the responsibilities of some important parts in the project. Please note that the list is not (meant to be) exhaustive.

.
├── components
│   ├── HomeScene
│   │   └── HomeScene // the entry point of the SceneGraph part of the app
│   ├── ServerRequesthander
│   │   ├── getRequestHandler,brs // the lowest level layer that handles network activities in the app
│   └── SceneFolder
│       ├── Homescreen // the main view of Home
│       ├── MovieDetailPage // ContentDetail Page when user click
│       ├── NavBar // top navbar in App
│       ├── VideoPlayer // Video Player
├── locale/default/fonts // the font files used in the app
├── locale/default/images // the image files used in the app
└── source
    ├── main.brs // the entry point of the app
    └── util.brs // utilities functions used on various places in the app
    └──  Apicenter.brs //Handel api call of App 
    
    
    
    
