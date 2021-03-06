//
//  AppDelegate.h
//  kStat
//
//  Created by Paweł Waleczek on 9/14/13.
//  Copyright (c) 2013 Paweł Waleczek. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
}

@property (assign) NSInteger keysPressedSession;
@property (assign) NSInteger keysPressed;

@property (strong) IBOutlet NSTextField *keystrokeCounter;

@property (assign) IBOutlet NSView *statView;

@property (strong) IBOutlet NSMenu *statMenu;

@property (strong, nonatomic) NSStatusItem *statusBar;

@property (strong) IBOutlet NSMenuItem *statInMenu;
@property (strong) IBOutlet NSMenuItem *statInMenuSession;
@end