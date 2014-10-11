# NSBundle+LoginItem
[![Build Status](https://travis-ci.org/nklizhe/NSBundle-LoginItem.svg?branch=master)](https://travis-ci.org/nklizhe/NSBundle-LoginItem)

A NSBundle category for adding / removing the bundle to LoginItems.

## Usage

```
#import <NSBundle+LoginItem/NSbundle+LoginItem.h>

// Add current application to LoginItems
[[NSBundle mainBundle] enableLoginItem];

// Remove current application from LoginItems
[[NSBundle mainBundle] disableLoginItem];
```

## Installation

NSBundle+LoginItem is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

pod "NSBundle+LoginItem"

## Author

Tom Li, nklizhe@gmail.com

## License

NSBundle+LoginItem is available under the MIT license. See the LICENSE file for more info.

