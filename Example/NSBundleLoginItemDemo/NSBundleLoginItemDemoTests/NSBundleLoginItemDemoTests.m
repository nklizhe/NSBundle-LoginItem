//
//  NSBundleLoginItemDemoTests.m
//  NSBundleLoginItemDemoTests
//
//  Created by Tom Li on 11/10/14.
//  Copyright (c) 2014 Inspirify Limited. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "NSBundle+LoginItem.h"

@interface NSBundleLoginItemDemoTests : XCTestCase

@end

@implementation NSBundleLoginItemDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [[NSBundle mainBundle] disableLoginItem];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNSBundleLoginItem {
    
    // This is an example of a functional test case.
    NSBundle *mainBundle = [NSBundle mainBundle];
    BOOL enabled = [mainBundle isLoginItemEnabled];
    XCTAssert(enabled == NO, @"LoginItem should be disabled initially");
    
    [mainBundle enableLoginItem];
    XCTAssert([mainBundle isLoginItemEnabled], @"LoginItem should be enabled now");
    XCTAssertTrue(mainBundle.openAtLogin, @"LoginItem should be enabled now");

    [mainBundle disableLoginItem];
    XCTAssert(![mainBundle isLoginItemEnabled], @"LoginItem should be disabled again");
    XCTAssertFalse(mainBundle.openAtLogin, @"LoginItem should be disabled now");
}

- (void)testDisableLoginItem {
    NSBundle *mainBundle = [NSBundle mainBundle];
    BOOL enabled = [mainBundle isLoginItemEnabled];
    XCTAssert(enabled == NO, @"LoginItem should be disabled initially");
   
    for (int i=0; i<1000; i++) {
        [mainBundle disableLoginItem];
        XCTAssert(![mainBundle isLoginItemEnabled], @"LoginItem should be disabled again");
    }
    
    [mainBundle disableLoginItem];
    XCTAssert(![mainBundle isLoginItemEnabled], @"LoginItem should be disabled again");
}

@end
