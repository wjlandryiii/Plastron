//
//  MouseMode_VanishingPoints.m
//  Plastron
//
//  Created by Joseph Landry on 9/29/13.
//  Copyright (c) 2013 Joseph Landry. All rights reserved.
//

#import "MouseMode_VanishingPoints.h"
#import "World.h"
#import "VanishingPoint.h"

@implementation MouseMode_VanishingPoints

-(void)click:(NSPoint)point Selection:(int) s{
    /*World *w = [World getWorld];
    VanishingPoint *vp = [w vanishingPointAtIndex:s];
    
    clickPoint = point;
    selection = s;
    
    if(vp != NULL){
        clickDelta = NSMakePoint(vp.point.x - clickPoint.x, vp.point.y - clickPoint.y);
    }
     */
    
}

-(void)moved:(NSPoint)point{
    /*
    World *w = [World getWorld];
    VanishingPoint *vp;
    
    if(selection >= 0){
        vp = [w vanishingPointAtIndex:selection];
        vp.point = NSMakePoint(point.x + clickDelta.x, point.y + clickDelta.y);
    }
     */
}

-(void)stop:(NSPoint)point{
    
}

@end
