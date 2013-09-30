//
//  Line.h
//  Plastron
//
//  Created by Joseph Landry on 9/29/13.
//  Copyright (c) 2013 Joseph Landry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Line : NSObject{
    NSPoint p1;
    NSPoint p2;
}

@property (nonatomic, assign) NSPoint p1;
@property (nonatomic, assign) NSPoint p2;

-(BOOL)doesSlopeExist;
-(CGFloat) slope;
-(NSPoint) midpoint;
-(CGFloat) y_intercept;
-(BOOL) doesIntersectionExist:(Line *)line;
-(NSPoint) intersection:(Line *)line;

@end
