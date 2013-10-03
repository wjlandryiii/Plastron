//
//  MainWindow.h
//  Plastron
//
//  Created by Joseph Landry on 9/29/13.
//  Copyright (c) 2013 Joseph Landry. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PerspectiveView.h"

@interface MainWindow : NSWindow
@property (assign) IBOutlet PerspectiveView *perspectiveView;
@property (assign) IBOutlet NSWindow *sizeSheetWindow;
@property (assign) IBOutlet NSTextField *sizeSheetHeight;
@property (assign) IBOutlet NSTextField *sizeSheetWidth;
-(void) pasteImage;
-(void) showSizeSheet;
-(void) showOpenImageDialog;
- (IBAction)pushedSizeSheetOK:(id)sender;
- (IBAction)pushedSizeSheetCancel:(id)sender;

@end
