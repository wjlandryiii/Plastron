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
    NSPoint p;
    
    NSLog(@"%@", theEvent);
    if(theEvent.modifierFlags == 0x40101){
        if([theEvent.charactersIgnoringModifiers isEqualToString:@"="]){
            NSLog(@"ZOOM IN");
            [self.perspectiveView zoomIn];
        }
        if([theEvent.charactersIgnoringModifiers isEqualToString:@"-"]){
            NSLog(@"Zoom out");
            [self.perspectiveView zoomOut];
        }
    }
    if(theEvent.keyCode == 53){
        [self.perspectiveView clearSelection];
    }
    if([theEvent.characters isEqualToString:@"1"]){
        p = [self mouseLocationOutsideOfEventStream];
        [self.perspectiveView dropVanishingPoint:0 AtPoint:p];
    }
    if([theEvent.characters isEqualToString:@"2"]){
        p = [self mouseLocationOutsideOfEventStream];
        [self.perspectiveView dropVanishingPoint:1 AtPoint:p];
    }
    if([theEvent.characters isEqualToString:@"3"]){
        p = [self mouseLocationOutsideOfEventStream];
        [self.perspectiveView dropVanishingPoint:2 AtPoint:p];
    }
    if([theEvent.characters isEqualToString:@"4"]){
        p = [self mouseLocationOutsideOfEventStream];
        [self.perspectiveView dropVanishingPoint:3 AtPoint:p];
    }
    if([theEvent.characters isEqualToString:@"5"]){
        p = [self mouseLocationOutsideOfEventStream];
        [self.perspectiveView dropVanishingPoint:4 AtPoint:p];
    }
    if([theEvent.characters isEqualToString:@"6"]){
        p = [self mouseLocationOutsideOfEventStream];
        [self.perspectiveView dropVanishingPoint:5 AtPoint:p];
    }
    if([theEvent.characters isEqualToString:@"7"]){
        p = [self mouseLocationOutsideOfEventStream];
        [self.perspectiveView dropVanishingPoint:6 AtPoint:p];
    }
    if([theEvent.characters isEqualToString:@"8"]){
        p = [self mouseLocationOutsideOfEventStream];
        [self.perspectiveView dropVanishingPoint:7 AtPoint:p];
    }
    if([theEvent.characters isEqualToString:@"9"]){
        p = [self mouseLocationOutsideOfEventStream];
        [self.perspectiveView dropVanishingPoint:8 AtPoint:p];
    }
    if(theEvent.keyCode == 126){ //UP
        [self.perspectiveView increaseDensity];
    }
    if(theEvent.keyCode == 125){ //DOWN
        [self.perspectiveView decreaseDensity];
    }
    if(theEvent.keyCode == 123){ //LEFT
        
    }
    if(theEvent.keyCode == 124){ //RIGHT
        
    }
    if([theEvent.charactersIgnoringModifiers isEqualToString:@"!"] && theEvent.modifierFlags == 0x60103){
        [self.perspectiveView dropVanishingPointAtIntersection:0];
    }
    if([theEvent.charactersIgnoringModifiers isEqualToString:@"@"] && theEvent.modifierFlags == 0x60103){
        [self.perspectiveView dropVanishingPointAtIntersection:1];
    }
    if([theEvent.charactersIgnoringModifiers isEqualToString:@"#"] && theEvent.modifierFlags == 0x60103){
        [self.perspectiveView dropVanishingPointAtIntersection:2];
    }
    if([theEvent.charactersIgnoringModifiers isEqualToString:@"$"] && theEvent.modifierFlags == 0x60103){
        [self.perspectiveView dropVanishingPointAtIntersection:3];
    }
    if([theEvent.charactersIgnoringModifiers isEqualToString:@"%"] && theEvent.modifierFlags == 0x60103){
        [self.perspectiveView dropVanishingPointAtIntersection:4];
    }
    if([theEvent.charactersIgnoringModifiers isEqualToString:@"^"] && theEvent.modifierFlags == 0x60103){
        [self.perspectiveView dropVanishingPointAtIntersection:5];
    }
    if([theEvent.charactersIgnoringModifiers isEqualToString:@"&"] && theEvent.modifierFlags == 0x60103){
        [self.perspectiveView dropVanishingPointAtIntersection:6];
    }
    if([theEvent.charactersIgnoringModifiers isEqualToString:@"*"] && theEvent.modifierFlags == 0x60103){
        [self.perspectiveView dropVanishingPointAtIntersection:7];
    }
    if([theEvent.charactersIgnoringModifiers isEqualToString:@"("] && theEvent.modifierFlags == 0x60103){
        [self.perspectiveView dropVanishingPointAtIntersection:8];
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
