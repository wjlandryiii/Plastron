//
//  Renderer.m
//  Plastron
//
//  Created by Joseph Landry on 9/29/13.
//  Copyright (c) 2013 Joseph Landry. All rights reserved.
//

#import "Renderer.h"


@implementation Renderer

-(void)renderWorld:(World *)world{
    int i;
    
    [[NSColor whiteColor] set];
    NSRectFill(NSMakeRect(0.0f, 0.0f, world.size.width, world.size.height));
    
    for(i = 0; i < world.maxVanishingPoints; i++){
        [self renderVanishingPoint:[world vanishingPointAtIndex:i]];
    }
    
}

-(void)renderVanishingPoint:(VanishingPoint *)vanishingPoint{
    if(vanishingPoint == NULL)
        return;
    
    //World *world = [World getWorld];
    
    
    int i;
    
    CGFloat step = 360.0/4.0/(CGFloat)vanishingPoint.density;
    
    for(i = 0; i < vanishingPoint.density; i++){
        NSAffineTransform *t = [NSAffineTransform transform];
        [t translateXBy:vanishingPoint.point.x yBy:vanishingPoint.point.y];
        [t rotateByDegrees:step * i];
        [t concat];
        [self DrawLineStart:NSMakePoint(0, -1000) Stop:NSMakePoint(0, 1000) Stroke:[NSColor blueColor]];
        [self DrawLineStart:NSMakePoint(-1000, 0) Stop:NSMakePoint(1000, 0) Stroke:[NSColor blueColor]];
        [t invert];
        [t concat];
    }
    if(vanishingPoint.selected){
        [self DrawCircleCenter:vanishingPoint.point Radius:20.0f Stroke:[NSColor blackColor] Fill:[NSColor purpleColor]];
    } else {
        [self DrawCircleCenter:vanishingPoint.point Radius:20.0f Stroke:[NSColor blackColor] Fill:[NSColor darkGrayColor]];
    }
    //NSString *label = [NSString stringWithFormat:@"%ld", (long)index];
    //[world DrawText:label inRect:NSMakeRect(self.point.x - 20.0f, self.point.y - 20.0f, self.point.x+20.0f, self.point.y+20.0f)];
    [self DrawText:vanishingPoint.label AtPoint:vanishingPoint.point];
    
}

-(void) DrawCircleCenter:(NSPoint) center Radius:(CGFloat) radius Stroke:(NSColor *)stroke Fill:(NSColor *)fill{
    NSBezierPath* thePath = [NSBezierPath bezierPath];
    [fill setFill];
    [stroke setStroke];
    [thePath setLineWidth:2.0f];
    [thePath setWindingRule:NSEvenOddWindingRule];
    [thePath appendBezierPathWithArcWithCenter:center radius:radius startAngle:0.0f endAngle:360.0f];
    [thePath fill];
    [thePath stroke];
    
}

-(void) DrawLineStart:(NSPoint) start Stop:(NSPoint) stop Stroke:(NSColor *)stroke{
    NSBezierPath* thePath = [NSBezierPath bezierPath];
    [stroke setStroke];
    [thePath moveToPoint:start];
    [thePath lineToPoint:stop];
    [thePath stroke];
}

-(void) DrawText:(NSString *)text inRect:(NSRect)rect{
    [text drawInRect:rect withAttributes:nil];
}

-(void) DrawText:(NSString *)text AtPoint:(NSPoint)point{
    NSDictionary *attr = [[NSDictionary alloc] initWithObjectsAndKeys: [NSFont boldSystemFontOfSize:16.0], NSFontAttributeName, [NSColor whiteColor], NSForegroundColorAttributeName, nil];
    [text drawAtPoint:point withAttributes:attr];
}


@end
