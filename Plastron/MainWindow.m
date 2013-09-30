//
//  MainWindow.m
//  Plastron
//
//  Created by Joseph Landry on 9/29/13.
//  Copyright (c) 2013 Joseph Landry. All rights reserved.
//

#import "MainWindow.h"

@implementation MainWindow

- (BOOL)windowShouldZoom:(NSWindow *)window toFrame:(NSRect)newFrame{
    NSLog(@"SHouldZoom:");
    return YES;
}

- (void)smartMagnifyWithEvent:(NSEvent *)event{
    NSLog(@"smart zoom");
    
}

- (void)keyDown:(NSEvent *)theEvent{
    NSPoint p = [self mouseLocationOutsideOfEventStream];
    BOOL shift = (theEvent.modifierFlags & NSShiftKeyMask) == NSShiftKeyMask;
    BOOL alt = (theEvent.modifierFlags & NSAlternateKeyMask) == NSAlternateKeyMask;
    BOOL command = (theEvent.modifierFlags & NSCommandKeyMask) == NSCommandKeyMask;
    BOOL control = (theEvent.modifierFlags & NSControlKeyMask) == NSControlKeyMask;
    
    NSLog(@"%@", theEvent);
    
    
    switch(theEvent.keyCode){
        case 4:
            if(!shift && !alt && !command && !control) [self.perspectiveView alignVanishingPoints1_2_HorizontallyAtPoint:p];
            break;
        case 18: // 1
            if(!shift && !alt && !command && !control) [self.perspectiveView dropVanishingPoint:0 AtPoint:p];
            if(!shift && !alt && !command &&  control) [self.perspectiveView selectVanishingPoint:0];
            if(!shift &&  alt && !command && !control) [self.perspectiveView removeVanishingPoint:0];
            if( shift && !alt && !command &&  control) [self.perspectiveView dropVanishingPointAtIntersection:0];
            break;
        case 19: // 2
            if(!shift && !alt && !command && !control) [self.perspectiveView dropVanishingPoint:1 AtPoint:p];
            if(!shift && !alt && !command &&  control) [self.perspectiveView selectVanishingPoint:1];
            if(!shift &&  alt && !command && !control) [self.perspectiveView removeVanishingPoint:1];
            if( shift && !alt && !command &&  control) [self.perspectiveView dropVanishingPointAtIntersection:1];
            break;
        case 20: // 3
            if(!shift && !alt && !command && !control) [self.perspectiveView dropVanishingPoint:2 AtPoint:p];
            if(!shift && !alt && !command &&  control) [self.perspectiveView selectVanishingPoint:2];
            if(!shift &&  alt && !command && !control) [self.perspectiveView removeVanishingPoint:2];
            if( shift && !alt && !command &&  control) [self.perspectiveView dropVanishingPointAtIntersection:2];
            break;
        case 21: // 4
            if(!shift && !alt && !command && !control) [self.perspectiveView dropVanishingPoint:3 AtPoint:p];
            if(!shift && !alt && !command &&  control) [self.perspectiveView selectVanishingPoint:3];
            if(!shift &&  alt && !command && !control) [self.perspectiveView removeVanishingPoint:3];
            if( shift && !alt && !command &&  control) [self.perspectiveView dropVanishingPointAtIntersection:3];
            break;
        case 23: // 5
            if(!shift && !alt && !command && !control) [self.perspectiveView dropVanishingPoint:4 AtPoint:p];
            if(!shift && !alt && !command &&  control) [self.perspectiveView selectVanishingPoint:4];
            if(!shift &&  alt && !command && !control) [self.perspectiveView removeVanishingPoint:4];
            if( shift && !alt && !command &&  control) [self.perspectiveView dropVanishingPointAtIntersection:4];
            break;
        case 22: // 6
            if(!shift && !alt && !command && !control) [self.perspectiveView dropVanishingPoint:5 AtPoint:p];
            if(!shift && !alt && !command &&  control) [self.perspectiveView selectVanishingPoint:5];
            if(!shift &&  alt && !command && !control) [self.perspectiveView removeVanishingPoint:5];
            if( shift && !alt && !command &&  control) [self.perspectiveView dropVanishingPointAtIntersection:5];
            break;
        case 26: // 7
            if(!shift && !alt && !command && !control) [self.perspectiveView dropVanishingPoint:6 AtPoint:p];
            if(!shift && !alt && !command &&  control) [self.perspectiveView selectVanishingPoint:6];
            if(!shift &&  alt && !command && !control) [self.perspectiveView removeVanishingPoint:6];
            if( shift && !alt && !command &&  control) [self.perspectiveView dropVanishingPointAtIntersection:6];
            break;
        case 28: // 8
            if(!shift && !alt && !command && !control) [self.perspectiveView dropVanishingPoint:7 AtPoint:p];
            if(!shift && !alt && !command &&  control) [self.perspectiveView selectVanishingPoint:7];
            if(!shift &&  alt && !command && !control) [self.perspectiveView removeVanishingPoint:7];
            if( shift && !alt && !command &&  control) [self.perspectiveView dropVanishingPointAtIntersection:7];
            break;
        case 25: // 9
            if(!shift && !alt && !command && !control) [self.perspectiveView dropVanishingPoint:8 AtPoint:p];
            if(!shift && !alt && !command &&  control) [self.perspectiveView selectVanishingPoint:8];
            if(!shift &&  alt && !command && !control) [self.perspectiveView removeVanishingPoint:8];
            if( shift && !alt && !command &&  control) [self.perspectiveView dropVanishingPointAtIntersection:8];
            break;
        case 123: // LEFT
            break;
        case 124: // RIGHT
            break;
        case 125: // DOWN
            [self.perspectiveView decreaseDensity];
            break;
        case 126: // UP
            [self.perspectiveView increaseDensity];
            break;
        case 27: // -
            if(!shift && !alt && !command &&  control) [self.perspectiveView zoomOut];
            break;
        case 24: // =
            if(!shift && !alt && !command &&  control) [self.perspectiveView zoomIn];
            break;
        case 51: // Backspace
            if(!shift && !alt && !command && !control) [self.perspectiveView removeLastTraceLine];
            if(!shift &&  alt && !command && !control) [self.perspectiveView removeAllTraceLines];
            break;
    }
}

- (BOOL)canBecomeKeyWindow
{
    return YES;
}

- (BOOL)canBecomeMainWindow
{
    return YES;
}



@end
