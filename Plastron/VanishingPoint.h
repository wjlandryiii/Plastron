//
//  VanishingPoint.h
//  Plastron
//
//  Created by Joseph Landry on 9/28/13.
//  Copyright (c) 2013 Joseph Landry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VanishingPoint : NSObject {
    NSPoint point;
    NSInteger density;
    BOOL selected;
    NSString *label;
    NSColor *color;
}

@property (nonatomic, assign) NSPoint point;
//TODO set density to unsigned?
@property (nonatomic, assign) NSInteger density;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, retain) NSString *label;
@property (nonatomic, retain) NSColor *color;

@end
