//
//  ConfigWindowController.m
//  abundant fragrence
//
//  Created by jeff on 11/5/12.
//  Copyright (c) 2012 jeff. All rights reserved.
//

#import "ConfigWindowController.h"

@interface ConfigWindowController ()

@end

@implementation ConfigWindowController

- (void)setURL:(NSPathControl*)sender
{
    [delegate setPath:[[sender URL] path]];
}

- (void)pathControl:(NSPathControl *)pathControl willDisplayOpenPanel:(NSOpenPanel *)openPanel
{
	// change the wind title and choose buttons title
	[openPanel setAllowsMultipleSelection:NO];
	[openPanel setCanChooseDirectories:YES];
	[openPanel setCanChooseFiles:NO];
	[openPanel setResolvesAliases:YES];
	[openPanel setTitle:@"Choose a directory of images"];
	[openPanel setPrompt:@"Choose"];
}

- (id)initWithDelegate:(abundant_fragrenceView*)_delegate
{
    self = [super initWithWindowNibName:@"ConfigWindowController"];
    if (self) {
        delegate = _delegate;
    }
    return self;
}

- (IBAction)OK:(id)sender
{
    [delegate setPath:[[pathControl URL] path]];
    [NSApp endSheet:[self window]];
}

- (IBAction)cancel:(id)sender {}

@end
