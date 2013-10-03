//
//  MainWindow.m
//  Plastron
//
//  Created by Joseph Landry on 9/29/13.
//  Copyright (c) 2013 Joseph Landry. All rights reserved.
//

#import "MainWindow.h"

@implementation MainWindow

- (BOOL)windowShouldZoom:(NSWindow *)window toFrame:(NSRect)newFrame{
    NSLog(@"SHouldZoom:");
    return YES;
}

- (void)smartMagnifyWithEvent:(NSEvent *)event{
    NSLog(@"smart zoom");
    
}

- (void)keyDown:(NSEvent *)theEvent{
    NSPoint p = [self mouseLocationOutsideOfEventStream];
    BOOL shift = (theEvent.modifierFlags & NSShiftKeyMask) == NSShiftKeyMask;
    BOOL alt = (theEvent.modifierFlags & NSAlternateKeyMask) == NSAlternateKeyMask;
    BOOL command = (theEvent.modifierFlags & NSCommandKeyMask) == NSCommandKeyMask;
    BOOL control = (theEvent.modifierFlags & NSControlKeyMask) == NSControlKeyMask;
    
    NSLog(@"%@", theEvent);
    
    
    switch(theEvent.keyCode){
        case 4: // H
            if(!shift && !alt && !command && !control) [self.perspectiveView alignVanishingPoints1_2_HorizontallyAtPoint:p];
            break;
        case 5: //G
            if(!shift && !alt && !command && !control) [self.perspectiveView toggleGrid];
            if(!shift && !alt && !command &&  control) [self.perspectiveView cycleGridType];
            break;
        case 8: // C
            if(!shift && !alt && !command &&  control) [self.perspectiveView copyToPasteboard];
            break;
        case 15: // R
            if(!shift && !alt && !command &&  control) [self.perspectiveView reset];
            break;
        case 34: // I
            if(!shift && !alt && !command &&  control) [self showOpenImageDialog];
            if(!shift && !alt && !command && !control) [self.perspectiveView toggleBackground];
            if(!shift &&  alt && !command && !control) [self.perspectiveView setBackgroundImage:nil];
            break;
        case 45: // N
            if(!shift && !alt && !command &&  control) [self showSizeSheet];
            break;
        case 18: // 1
            if(!shift && !alt && !command && !control) [self.perspectiveView dropVanishingPoint:0 AtPoint:p];
            if(!shift && !alt && !command &&  control) [self.perspectiveView selectVanishingPoint:0];
            if(!shift &&  alt && !command && !control) [self.perspectiveView removeVanishingPoint:0];
            if( shift && !alt && !command &&  control) [self.perspectiveView dropVanishingPointAtIntersection:0];
            break;
        case 19: // 2
            if(!shift && !alt && !command && !control) [self.perspectiveView dropVanishingPoint:1 AtPoint:p];
            if(!shift && !alt && !command &&  control) [self.perspectiveView selectVanishingPoint:1];
            if(!shift &&  alt && !command && !control) [self.perspectiveView removeVanishingPoint:1];
            if( shift && !alt && !command &&  control) [self.perspectiveView dropVanishingPointAtIntersection:1];
            break;
        case 20: // 3
            if(!shift && !alt && !command && !control) [self.perspectiveView dropVanishingPoint:2 AtPoint:p];
            if(!shift && !alt && !command &&  control) [self.perspectiveView selectVanishingPoint:2];
            if(!shift &&  alt && !command && !control) [self.perspectiveView removeVanishingPoint:2];
            if( shift && !alt && !command &&  control) [self.perspectiveView dropVanishingPointAtIntersection:2];
            break;
        case 21: // 4
            if(!shift && !alt && !command && !control) [self.perspectiveView dropVanishingPoint:3 AtPoint:p];
            if(!shift && !alt && !command &&  control) [self.perspectiveView selectVanishingPoint:3];
            if(!shift &&  alt && !command && !control) [self.perspectiveView removeVanishingPoint:3];
            if( shift && !alt && !command &&  control) [self.perspectiveView dropVanishingPointAtIntersection:3];
            break;
        case 23: // 5
            if(!shift && !alt && !command && !control) [self.perspectiveView dropVanishingPoint:4 AtPoint:p];
            if(!shift && !alt && !command &&  control) [self.perspectiveView selectVanishingPoint:4];
            if(!shift &&  alt && !command && !control) [self.perspectiveView removeVanishingPoint:4];
            if( shift && !alt && !command &&  control) [self.perspectiveView dropVanishingPointAtIntersection:4];
            break;
        case 22: // 6
            if(!shift && !alt && !command && !control) [self.perspectiveView dropVanishingPoint:5 AtPoint:p];
            if(!shift && !alt && !command &&  control) [self.perspectiveView selectVanishingPoint:5];
            if(!shift &&  alt && !command && !control) [self.perspectiveView removeVanishingPoint:5];
            if( shift && !alt && !command &&  control) [self.perspectiveView dropVanishingPointAtIntersection:5];
            break;
        case 26: // 7
            if(!shift && !alt && !command && !control) [self.perspectiveView dropVanishingPoint:6 AtPoint:p];
            if(!shift && !alt && !command &&  control) [self.perspectiveView selectVanishingPoint:6];
            if(!shift &&  alt && !command && !control) [self.perspectiveView removeVanishingPoint:6];
            if( shift && !alt && !command &&  control) [self.perspectiveView dropVanishingPointAtIntersection:6];
            break;
        case 28: // 8
            if(!shift && !alt && !command && !control) [self.perspectiveView dropVanishingPoint:7 AtPoint:p];
            if(!shift && !alt && !command &&  control) [self.perspectiveView selectVanishingPoint:7];
            if(!shift &&  alt && !command && !control) [self.perspectiveView removeVanishingPoint:7];
            if( shift && !alt && !command &&  control) [self.perspectiveView dropVanishingPointAtIntersection:7];
            break;
        case 25: // 9
            if(!shift && !alt && !command && !control) [self.perspectiveView dropVanishingPoint:8 AtPoint:p];
            if(!shift && !alt && !command &&  control) [self.perspectiveView selectVanishingPoint:8];
            if(!shift &&  alt && !command && !control) [self.perspectiveView removeVanishingPoint:8];
            if( shift && !alt && !command &&  control) [self.perspectiveView dropVanishingPointAtIntersection:8];
            break;
        case 123: // LEFT
            break;
        case 124: // RIGHT
            break;
        case 125: // DOWN
            [self.perspectiveView decreaseDensity];
            break;
        case 126: // UP
            [self.perspectiveView increaseDensity];
            break;
        case 27: // -
            if(!shift && !alt && !command &&  control) [self.perspectiveView zoomOut];
            if(!shift && !alt && !command && !control) [self.perspectiveView decreaseGridSize];
            break;
        case 24: // =
            if(!shift && !alt && !command &&  control) [self.perspectiveView zoomIn];
            if(!shift && !alt && !command && !control) [self.perspectiveView increaseGridSize];
            break;
        case 51: // Backspace
            if(!shift && !alt && !command && !control) [self.perspectiveView removeLastTraceLine];
            if(!shift &&  alt && !command && !control) [self.perspectiveView removeAllTraceLines];
            break;
        case 53: // Escape
            if(!shift && !alt && !command && !control) [self.perspectiveView clearSelection];
            break;
        case 115: // Home
            if(!shift && !alt && !command && !control) [self.perspectiveView resetCamera];
            break;
    }
}

- (BOOL)canBecomeKeyWindow
{
    return YES;
}

- (BOOL)canBecomeMainWindow
{
    return YES;
}

-(void) showSizeSheet{
    NSSize s;
    
    if(!self.sizeSheetWindow)
        [[NSBundle mainBundle] loadNibNamed:@"SizeSheet" owner:self topLevelObjects:nil];
    
    [NSApp beginSheet:self.sizeSheetWindow modalForWindow:self modalDelegate:self didEndSelector:@selector(didEndSheet:returnCode:contextInfo:) contextInfo:nil];
    s = [self.perspectiveView currentWorldSize];
    [self.sizeSheetHeight setIntValue:s.height];
    [self.sizeSheetWidth setIntValue:s.width];
}

-(void) showOpenImageDialog{
    NSOpenPanel *openPanel = [[NSOpenPanel alloc]init];

    
    [openPanel beginSheetModalForWindow:self completionHandler:^(NSInteger result){
            NSImage *img;
        NSLog(@"FUCK");
        NSLog(@"%@", [openPanel.URL path]);
        if(result == NSFileHandlingPanelOKButton){
            img = [[NSImage alloc]initWithContentsOfFile:[openPanel.URL path]];
            if(img != nil){
                NSLog(@"image was not nil");
                [self.perspectiveView setBackgroundImage:img];
            }
        }
    }];
}

- (IBAction)pushedSizeSheetOK:(id)sender {
    NSSize size;
    size.height = [self.sizeSheetHeight intValue];
    size.width = [self.sizeSheetWidth intValue];
    [self.perspectiveView resizeWorld:size];
    [NSApp endSheet:self.sizeSheetWindow];
    NSLog(@"size.height: %f", size.height);
}

- (IBAction)pushedSizeSheetCancel:(id)sender {
    [NSApp endSheet:self.sizeSheetWindow];
}

- (void)didEndSheet:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
    self.sizeSheetWindow = nil;
    [sheet orderOut:self];
}
@end
