//
//  AppDelegate.m
//  kStat
//
//  Created by Paweł Waleczek on 9/14/13.
//  Copyright (c) 2013 Paweł Waleczek. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize statusBar = _statusBar;

- (void) awakeFromNib {
    self.statusBar = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    
    self.statusBar.title = @"G";
    
    // you can also set an image
    //self.statusBar.image =
    
    self.statusBar.menu = self.statMenu;
    self.statusBar.highlightMode = YES;
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

@end
