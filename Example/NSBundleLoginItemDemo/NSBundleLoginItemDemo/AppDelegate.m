//
//  AppDelegate.m
//  NSBundleLoginItemDemo
//
//  Created by Tom Li on 11/10/14.
//  Copyright (c) 2014 Inspirify Limited. All rights reserved.
//

#import "AppDelegate.h"
#import "NSBundle+LoginItem.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSButton *toggleLoginItem;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [self updateButtonLabel];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)toggleLoginItem:(id)sender {
    NSBundle *mainBundle = [NSBundle mainBundle];
    if ([mainBundle isLoginItemEnabled]) {
        [mainBundle disableLoginItem];
    } else {
        [mainBundle enableLoginItem];
    }
    
    [self updateButtonLabel];
}

- (void)updateButtonLabel {
    NSBundle *mainBundle = [NSBundle mainBundle];
    if ([mainBundle isLoginItemEnabled]) {
        [self.toggleLoginItem setTitle:@"Disable LoginItem"];
    } else {
        [self.toggleLoginItem setTitle:@"Enable LoginItem"];
    }
    [self.toggleLoginItem setNeedsDisplay:YES];
}

@end
