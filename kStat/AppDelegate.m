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
@synthesize statInMenu = _statInMenu;
@synthesize keysPressed = _keysPressed;
@synthesize keysPressedSession = _keysPressedSession;
@synthesize keystrokeCounter = _keystrokeCounter;


NSUserDefaults *preferences;


- (void) awakeFromNib {
    
    self.keysPressedSession = 0;
    
    preferences = [NSUserDefaults standardUserDefaults];
    
    self.keysPressed = [[preferences objectForKey:@"keysPressed"] intValue];
    
    NSString *file = [[NSBundle mainBundle]
                      pathForResource:@"Defaults" ofType:@"plist"];
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:file];
    [preferences registerDefaults:dict];
    
    NSLog(@"Loading prefs. %ld, %d", self.keysPressed, [[preferences objectForKey:@"keysPressed"] intValue]);

    
    self.statusBar = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    
    NSFont *font = [NSFont fontWithName:@"Times-BoldItalic" size:14.5];
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"∑" attributes:attrsDictionary];

    
    [self.statusBar setAttributedTitle:attrString];
    
    self.keysPressed = [[preferences objectForKey:@"keysPressed"] intValue];
    
    [self.statInMenu setTitle:[NSString stringWithFormat:@"Total: %@", [self setFormat: self.keysPressed]]];
    
    [self.statInMenuSession setTitle:[NSString stringWithFormat:@"This session: %@", [self setFormat: self.keysPressedSession]]];
    
    [self.keystrokeCounter setStringValue: [NSString stringWithFormat:@"Keys pressed: %@", [self setFormat: self.keysPressed]]];
    [self.statusBar setMenu:self.statMenu];
    [self.statusBar setHighlightMode:YES];
}

- (NSString *) setFormat:(NSInteger)value {
    NSNumberFormatter *numberFormat = [[NSNumberFormatter alloc] init];
    numberFormat.usesGroupingSeparator = YES;
    numberFormat.groupingSeparator = @" ";
    numberFormat.groupingSize = 3;
    
    NSString *result = [numberFormat stringFromNumber:[NSNumber numberWithInteger:value]];
    return result;
}

- (void) updateKeyPresses {
    self.keysPressed++;
    self.keysPressedSession++;
    [preferences setInteger:self.keysPressed forKey:@"keysPressed"];
    
    [self.keystrokeCounter setStringValue: [NSString stringWithFormat:@"Keys pressed: %@", [self setFormat: self.keysPressed]]];
    
    [self.statInMenu setTitle:[NSString stringWithFormat:@"Keys pressed: %@", [self setFormat: self.keysPressed]]];
    
    [self.statInMenuSession setTitle:[NSString stringWithFormat:@"This session: %@", [self setFormat: self.keysPressedSession]]];
    
}

-(void) savePrefs:(NSTimer *)timer {
    [preferences synchronize];
    NSLog(@"Saving prefs.");
}

- (void) applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [NSTimer scheduledTimerWithTimeInterval: 60.0
                                     target: self
                                   selector: @selector(savePrefs:)
                                   userInfo: nil
                                    repeats: YES];
    
    [NSEvent addGlobalMonitorForEventsMatchingMask:(NSKeyDownMask + NSAlternateKeyMask + NSShiftKeyMask + NSFunctionKeyMask + NSCommandKeyMask) handler:^(NSEvent *event){
        
        [self updateKeyPresses];
        
        NSLog(@"%@ pressed!", event.characters);
    }];
}

@end
