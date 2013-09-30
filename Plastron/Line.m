//
//  Line.m
//  Plastron
//
//  Created by Joseph Landry on 9/29/13.
//  Copyright (c) 2013 Joseph Landry. All rights reserved.
//

#import "Line.h"

@implementation Line

@synthesize p1;
@synthesize p2;

-(BOOL)doesSlopeExist{
    if(p1.x - p2.x == 0)
        return FALSE;
    return TRUE;
}

-(CGFloat) slope{
    return (p2.y - p1.y) / (p2.x - p1.x);
}

-(NSPoint) midpoint{
    NSPoint m;
    
    m.x = (p1.x + p2.x) / 2.0f;
    m.y = (p1.y + p2.y) / 2.0f;
    return m;
}

-(CGFloat) y_intercept{
    return p1.y - ([self slope] * p1.x);
}

-(BOOL) doesIntersectionExist:(Line *)line{
    if([self doesSlopeExist] && [line doesSlopeExist]){
        if([self slope] != [line slope]){
            return YES;
        }
    } else if([self doesSlopeExist] || [line doesSlopeExist]) {
        return YES;
    }
    return NO;
}

-(NSPoint) intersection:(Line *)line{
    NSPoint n;
    
    if([self doesSlopeExist] && [line doesSlopeExist]){
        if([self slope] != [line slope]){
            n.x = ([self y_intercept] - [line y_intercept]) / ([line slope] - [self slope]);
            n.y = ([self slope] * n.x) + [self y_intercept];
        }
    } else if(![self doesSlopeExist]){
        n.x = self.p1.x;
        n.y = [line slope] * n.x + [line y_intercept];
    } else if(![line doesSlopeExist]){
        n.x = line.p1.x;
        n.y = [self slope] * n.x + [self y_intercept];
    }
    return n;
}

@end
