# UIAutoScroll Example App

[![platform](https://img.shields.io/badge/platform-iOS-brightgreen)](https://developer.apple.com/)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://en.wikipedia.org/wiki/MIT_License)
[![xcode-version](https://img.shields.io/badge/xcode-13.2.1-brightgreen)](https://developer.apple.com/xcode/)
[![swift-version](https://img.shields.io/badge/swift-5.5-blue.svg)](https://github.com/apple/swift)

![Alt Text](./resource/preview.gif)

## Requirements

- iOS device (virtual device is not supported)
- [SeeSo](https://seeso.io) License Key & Framework.
- Supports iOS 13.0 and above.
- Requires network connected environment.

## Build


1. After receiving the framework from [SeeSo](https://seeso.io), import it into the project. Make sure the framework Embed option is "Embed & Sign". Refer to [documentation](https://docs.seeso.io) for details.

![image](./resource/build1.png)


2. Get the development key from [SeeSo Manage](https://manage.seeso.io) and put the key value in the `license` in ViewControl. 

```swift
  var license : String = "Input your key." 
```

## How to use the app

![usage1](./resource/usage1.gif)  ![usage2](./resource/usage2.gif) ![usage3](./resource/usage3.gif)

1. Click the start button.
2. Keep your eye on the dot located in center of the screen for gaze calibration.  
3. Read the text naturally. You should notice the text scrolling. If you read faster, the scrolling speed should adjust to your reading speed.

## Framework

### Manual

- [SeeSo](https://seeso.io) 

### Swift Package Manager
- [MKRingProgressView](https://github.com/maxkonovalov/MKRingProgressView)
- [UIAutoScroll](https://github.com/visualcamp/UIAutoScroll)

## License 

The MIT License (MIT)

Copyright (c) 2021 [SeeSo](https://seeso.io)
