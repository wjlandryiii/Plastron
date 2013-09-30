//
//  MouseMode_VanishingPoints.h
//  Plastron
//
//  Created by Joseph Landry on 9/29/13.
//  Copyright (c) 2013 Joseph Landry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MouseMode_VanishingPoints : NSObject{
    NSPoint clickPoint;
    NSPoint clickDelta;
    int selection;
}

-(void)click:(NSPoint)point Selection:(int) s;
-(void)moved:(NSPoint)point;
-(void)stop:(NSPoint)point;

@end
