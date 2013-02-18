//
//  ConfigWindowController.h
//  abundant fragrence
//
//  Created by jeff on 11/5/12.
//  Copyright (c) 2012 jeff. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "abundant_fragrenceView.h"
@class abundant_fragrenceView;

@interface ConfigWindowController : NSWindowController
{
    abundant_fragrenceView* delegate;
    IBOutlet NSPathControl* pathControl;
}

- (id)initWithDelegate:(abundant_fragrenceView*)_delegate;
- (IBAction)setURL:(id)sender;
- (IBAction)OK:(id)sender;
- (IBAction)cancel:(id)sender;

@end
