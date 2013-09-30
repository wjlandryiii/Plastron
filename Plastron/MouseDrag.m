//
//  MouseDrag.m
//  Plastron
//
//  Created by Joseph Landry on 9/29/13.
//  Copyright (c) 2013 Joseph Landry. All rights reserved.
//

#import "MouseDrag.h"

@implementation MouseDrag

@synthesize startPoint;
@synthesize originPoint;
@synthesize delta;
@synthesize stopPoint;
@synthesize resultantOrigin;

-(void)startAtPoint:(NSPoint) start WithOrigin:(NSPoint) origin{
    startPoint = start;
    originPoint = origin;
    
    delta.x = origin.x - start.x;
    delta.y = origin.y - start.y;
    
}

-(void)update:(NSPoint) point{
    stopPoint = point;
    resultantOrigin.x = stopPoint.x + delta.x;
    resultantOrigin.y = stopPoint.y + delta.y;
}

@end
