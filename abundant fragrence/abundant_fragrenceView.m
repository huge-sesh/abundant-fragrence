//
//  abundant_fragrenceView.m
//  abundant fragrence
//
//  Created by jeff on 11/5/12.
//  Copyright (c) 2012 jeff. All rights reserved.
//

#import "abundant_fragrenceView.h"
#import <CoreImage/CoreImage.h>
@implementation abundant_fragrenceView

unsigned int tweenCount = 30;

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        images = [[NSMutableArray alloc] init];
        step = 0;
        
        NSDictionary* defaults = [[NSUserDefaults standardUserDefaults] persistentDomainForName:@"com.apple.systempreferences"];
        if ([defaults objectForKey:@"fragrence_path"] != nil) {
            [self setPath:[defaults objectForKey:@"fragrence_path"]];
        } else
            [self setPath:[NSString stringWithFormat:@"%@/Pictures", NSHomeDirectory()]];
        [self setAnimationTimeInterval:1/20.0];
    }
    return self;
}

- (IBAction)setPath:(NSString*)path
{
    NSURL* url = [NSURL URLWithString:path];
    [[NSUserDefaults standardUserDefaults] setObject:path forKey:@"fragrence_path"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"set path: %@, %@", path, url);
    NSArray *content = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:url
                                                     includingPropertiesForKeys:nil
                                                                        options:NSDirectoryEnumerationSkipsHiddenFiles
                                                                          error:nil];
    NSMutableArray* raws = [NSMutableArray array];
    [images removeAllObjects];
    step = 0;
    for (NSURL *imageURL in content)
    {
        if ([[imageURL pathExtension] hasSuffix:@"png"]  ||
            [[imageURL pathExtension] hasSuffix:@"jpg"]  ||
            [[imageURL pathExtension] hasSuffix:@"gif"]  ||
            [[imageURL pathExtension] hasSuffix:@"jpeg"] ||
            [[imageURL pathExtension] hasSuffix:@"tga"]) {
            [raws addObject:[CIImage imageWithContentsOfURL:imageURL]];
        }
    }
    CIFilter *filter = [CIFilter filterWithName:@"CIDissolveTransition"];
    
    //generate all the images at once
    for (unsigned int i = 0; i < [raws count]; i++) {
        [images addObject:[raws objectAtIndex:i]];
        for (unsigned int j = 1; j <= tweenCount; j++) {
            float delta = j * (1.0f / (tweenCount +1));
            [filter setValuesForKeysWithDictionary:
             [NSDictionary dictionaryWithObjectsAndKeys:
              [raws objectAtIndex:i], @"inputImage",
              [raws objectAtIndex:(i +1) % [raws count]], @"inputTargetImage",
              [NSNumber numberWithFloat:delta], @"inputTime",
              nil]];
            [images addObject:[filter valueForKey:kCIOutputImageKey]];
        }
    }
}

//actual update method called by screensaverengine
- (void)animateOneFrame
{
    if (nil == images || [images count] == 0 ) return;
    step = ++step % [images count];
    CIImage* image = [images objectAtIndex:step];
    CIContext* context = [CIContext contextWithCGContext:[[NSGraphicsContext currentContext] graphicsPort] options:nil];
    [context drawImage:image inRect:[self frame] fromRect:[image extent]];
    return;
}

- (BOOL)hasConfigureSheet
{
    return YES;
}

- (NSWindow*)configureSheet
{
    if (nil == configWindow) configWindow = [[ConfigWindowController alloc] initWithDelegate:self];
    return [configWindow window];
}

- (IBAction)closeSheetOK:(id)sender
{
    // close sheet
    [NSApp endSheet:[configWindow window]];
    return;
}

@end
