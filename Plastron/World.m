//
//  World.m
//  Plastron
//
//  Created by Joseph Landry on 9/28/13.
//  Copyright (c) 2013 Joseph Landry. All rights reserved.
//

#import "World.h"

World *w;

@implementation World

+(World *)getWorld{
    if(w == NULL)
        w = [[World alloc]init];
    return w;
}

-(id) init{
    self = [super init];
    if(self){
        vanishingPoints[0] = [[VanishingPoint alloc]init];
        vanishingPoints[0].point = NSMakePoint(100.0f, 100.0f);
        vanishingPoints[0].density = 10;
        vanishingPoints[1] = [[VanishingPoint alloc]init];
        vanishingPoints[1].point = NSMakePoint(420.0f, 240.0f);
        vanishingPoints[1].density = 20;
    }
    return self;
}

-(void)reset{
    int i;
    for(i = 0; i < 9; i++){
        //TODO memory leak
        vanishingPoints[i] = NULL;
    }
}

-(void)Draw{
    int i;
    
    for(i = 0; i < 9; i++){
        [vanishingPoints[i] Draw:i+1 Selected:(selection == i ? YES : NO)];
    }
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

-(VanishingPoint *)vanishingPointAtIndex:(int)index{
    if(!(0 <= index && index < 9))
        return NULL;
    return vanishingPoints[index];
}

-(void) setVanishingPoint:(VanishingPoint *)vp WithIndex:(int)index{
    if(!(0 <= index && index < 9))
        return;
    vanishingPoints[index] = vp;
}

-(void) setSelection:(int)newSelection{
    selection = newSelection;
}

-(int)selection{
    return selection;
}

@end
