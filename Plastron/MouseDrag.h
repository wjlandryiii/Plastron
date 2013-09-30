//
//  MouseDrag.h
//  Plastron
//
//  Created by Joseph Landry on 9/29/13.
//  Copyright (c) 2013 Joseph Landry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MouseDrag : NSObject {
    NSPoint startPoint;
    NSPoint originPoint;
    NSPoint delta;
    NSPoint stopPoint;
    NSPoint resultantOrigin;
}

@property (nonatomic, assign) NSPoint startPoint;
@property (nonatomic, assign) NSPoint originPoint;
@property (nonatomic, assign) NSPoint delta;
@property (nonatomic, assign) NSPoint stopPoint;
@property (nonatomic, assign) NSPoint resultantOrigin;

-(void)startAtPoint:(NSPoint) start WithOrigin:(NSPoint) origin;
-(void)update:(NSPoint) point;

@end
