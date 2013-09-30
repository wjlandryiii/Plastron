//
//  VanishingPoint.m
//  Plastron
//
//  Created by Joseph Landry on 9/28/13.
//  Copyright (c) 2013 Joseph Landry. All rights reserved.
//

#import "VanishingPoint.h"
#import "World.h"

@implementation VanishingPoint

@synthesize point;
@synthesize density;

-(void) Draw:(NSInteger) index Selected:(BOOL) selected{
    World *world = [World getWorld];
    

    int i;
    
    CGFloat step = 360.0/4.0/(CGFloat)self.density;
    
    for(i = 0; i < self.density; i++){
        NSAffineTransform *t = [NSAffineTransform transform];
        [t translateXBy:self.point.x yBy:self.point.y];
        [t rotateByDegrees:step * i];
        [t concat];
        [world DrawLineStart:NSMakePoint(0, -1000) Stop:NSMakePoint(0, 1000) Stroke:[NSColor blueColor]];
        [world DrawLineStart:NSMakePoint(-1000, 0) Stop:NSMakePoint(1000, 0) Stroke:[NSColor blueColor]];
        [t invert];
        [t concat];
    }
    if(selected){
        [world DrawCircleCenter:self.point Radius:20.0f Stroke:[NSColor blackColor] Fill:[NSColor purpleColor]];
    } else {
        [world DrawCircleCenter:self.point Radius:20.0f Stroke:[NSColor blackColor] Fill:[NSColor darkGrayColor]];
    }
    NSString *label = [NSString stringWithFormat:@"%ld", (long)index];
    //[world DrawText:label inRect:NSMakeRect(self.point.x - 20.0f, self.point.y - 20.0f, self.point.x+20.0f, self.point.y+20.0f)];

    [world DrawText:label AtPoint:self.point];
}

@end
