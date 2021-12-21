# UIAutoScroll Example App

[![platform](https://img.shields.io/badge/platform-iOS-brightgreen)](https://developer.apple.com/)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://en.wikipedia.org/wiki/MIT_License)
[![xcode-version](https://img.shields.io/badge/xcode-13.2.1-brightgreen)](https://developer.apple.com/xcode/)
[![swift-version](https://img.shields.io/badge/swift-5.5-blue.svg)](https://github.com/apple/swift)

![Alt Text](./resource/preview.gif)

## Requirements

- iOS real device.
- [SeeSo](https://seeso.io) License Key & [SeeSo](https://seeso.io) Framework.
- iOS 13.0 
- Network connected environment

## Build


1. After receiving the framework from [SeeSo](https://seeso.io), import it into the project. At this time, the embed & signing option is provided. See [document](https://docs.seeso.io) for details.

![image](./resource/build1.png)


2. Get the dev key from [SeeSo Manage](https://manage.seeso.io) and put the key value in the license variable of ViewControl. 

```swift
  var license : String = "Input your key." 
```

## How to use the app

![usage1](./resource/usage1.gif)  ![usage2](./resource/usage2.gif) ![usage3](./resource/usage3.gif)

1. click start button.
2. Keep an eye on the center of the screen.  
3. If you read the text naturally, it scrolls little by little, and if you look at the bottom of the screen, it scrolls for a long time.


## Framework

### Manual

- [SeeSo](https://seeso.io) 

### Swift Package Manager
- [MKRingProgressView](https://github.com/maxkonovalov/MKRingProgressView)
- [UIAutoScroll](https://github.com/visualcamp/UIAutoScroll)

## License 

The MIT License (MIT)

Copyright (c) 2021 [SeeSo](https://seeso.io)
