//
//  NSBundle+LoginItem.m
//
//  Created by Tom Li on 11/10/14.
//  Copyright (c) 2014 Inspirify Limited. All rights reserved.
//

#import "NSBundle+LoginItem.h"
#import <AppKit/AppKit.h>

@implementation NSBundle (LoginItem)

//-------------------------------------------------------------------------------------------------------------
- (void)enableLoginItem
{
    if([self isLoginItemEnabled]) {
        return;
    }
    
    [self setEnabledAtLogin:YES];
}

//-------------------------------------------------------------------------------------------------------------
- (void)disableLoginItem
{
    [self setEnabledAtLogin:NO];
}

//-------------------------------------------------------------------------------------------------------------
- (void)setEnabledAtLogin:(BOOL)enabled
{
    [self iterateOverLoginItemsWithBlock:^(LSSharedFileListRef sharedFileList, LSSharedFileListItemRef sharedFileListItem, NSURL *appURL) {
        NSBundle *appBundle = [NSBundle bundleWithURL:appURL];
        if(appBundle && [appBundle.bundleIdentifier isEqualToString:self.bundleIdentifier]) {
            LSSharedFileListItemRemove(sharedFileList, sharedFileListItem);
        }
    }];
    
    if(enabled) {
        LSSharedFileListRef sharedFileList = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
        if(!sharedFileList) {
            NSLog(@"Unable to create shared file list!");
            return;
        }
        NSURL *appURL = [NSURL fileURLWithPath:self.bundlePath];
        LSSharedFileListItemRef sharedFileListItem = LSSharedFileListInsertItemURL(sharedFileList, kLSSharedFileListItemLast, NULL, NULL, (__bridge CFURLRef)appURL, NULL, NULL);
        if(sharedFileListItem) {
            CFRelease(sharedFileListItem);
        }
        CFRelease(sharedFileList);
    }
}

//-------------------------------------------------------------------------------------------------------------
- (BOOL)isLoginItemEnabled
{
    __block BOOL result = NO;
    [self iterateOverLoginItemsWithBlock:^(LSSharedFileListRef sharedFileList, LSSharedFileListItemRef sharedFileListItem, NSURL *appURL) {
        NSString *resolvedApplicationPath = [appURL path];
        if(resolvedApplicationPath && [resolvedApplicationPath compare:self.bundlePath] == NSOrderedSame) {
            result = YES;
        }
    }];
    return result;
}

//-------------------------------------------------------------------------------------------------------------
- (void)setHiddenAtLogin:(BOOL)hidden
{
    NSURL *myURL = [NSURL fileURLWithPath:self.bundlePath];
    
    [self iterateOverLoginItemsWithBlock:^(LSSharedFileListRef sharedFileList, LSSharedFileListItemRef sharedFileListItem, NSURL *appURL) {
        if([myURL isEqualTo:appURL]) {
            LSSharedFileListItemSetProperty(sharedFileListItem, kLSSharedFileListLoginItemHidden, (__bridge CFBooleanRef)@(hidden));
        }
    }];
}

//-------------------------------------------------------------------------------------------------------------
- (BOOL)isHiddenAtLogin
{
    __block BOOL result = NO;
    NSURL *myURL = [NSURL fileURLWithPath:self.bundlePath];
    
    [self iterateOverLoginItemsWithBlock:^(LSSharedFileListRef sharedFileList, LSSharedFileListItemRef sharedFileListItem, NSURL *appURL) {
        if([myURL isEqualTo:appURL]) {
            CFBooleanRef value = LSSharedFileListItemCopyProperty(sharedFileListItem, kLSSharedFileListLoginItemHidden);
            if(value) {
                result = CFBooleanGetValue(value);
                CFRelease(value);
            }
        }
    }];
    
    return result;
}

//-------------------------------------------------------------------------------------------------------------
- (void)iterateOverLoginItemsWithBlock:(void(^)(LSSharedFileListRef, LSSharedFileListItemRef, NSURL*))block
{
    LSSharedFileListRef sharedFileList = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    if(!sharedFileList) {
        NSLog(@"Unable to create shared file list!");
        return;
    }
    
    UInt32 seedValue;
    CFArrayRef sharedFileListArray = LSSharedFileListCopySnapshot(sharedFileList, &seedValue);
    if(sharedFileListArray) {
        for(id sharedFile in (__bridge NSArray *)sharedFileListArray) {
            if(sharedFile) {
                LSSharedFileListItemRef sharedFileListItem = (__bridge LSSharedFileListItemRef)sharedFile;
                CFURLRef appURL = LSSharedFileListItemCopyResolvedURL(sharedFileListItem, kLSSharedFileListNoUserInteraction, NULL);
                if(appURL) {
                    block(sharedFileList, sharedFileListItem, (__bridge NSURL *)appURL);
                    CFRelease(appURL);
                }
            }
        }
        CFRelease(sharedFileListArray);
    }
    CFRelease(sharedFileList);
}
@end
