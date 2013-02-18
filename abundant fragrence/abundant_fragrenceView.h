//
//  abundant_fragrenceView.h
//  abundant fragrence
//
//  Created by jeff on 11/5/12.
//  Copyright (c) 2012 jeff. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>
#import "ConfigWindowController.h"
@class ConfigWindowController;

@interface abundant_fragrenceView : ScreenSaverView
{
    NSMutableArray* images;
    //CIContext* context;
    unsigned int step;
    ConfigWindowController* configWindow;
}
- (IBAction) setPath:(NSString*) path;
@end
