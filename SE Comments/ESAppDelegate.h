//
//  ESAppDelegate.h
//  SE Comments
//
//  Created by Parker on 10/28/13.
//  Copyright (c) 2013 Parker Erway. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ESAppDelegate : NSObject <NSApplicationDelegate, NSTableViewDataSource, NSTableViewDelegate, NSTextFieldDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *userIDField;
@property (weak) IBOutlet NSTextField *siteAPIKeyField;
- (IBAction)fetchComments:(id)sender;
@property (weak) IBOutlet NSTextField *numCommentsLabel;
@property (weak) IBOutlet NSTableView *tableView;
@property (nonatomic, strong) NSArray *comments;
@property (weak) IBOutlet NSTextField *searchTextField;
- (IBAction)search:(id)sender;
@property (nonatomic) BOOL isSearching;
@property (nonatomic, strong) NSMutableArray *searchResults;
@end
