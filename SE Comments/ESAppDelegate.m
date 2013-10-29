//
//  ESAppDelegate.m
//  SE Comments
//
//  Created by Parker on 10/28/13.
//  Copyright (c) 2013 Parker Erway. All rights reserved.
//

#import "ESAppDelegate.h"
#import "NSString+HTML.h"
#import "NSString+Contains.h"
@implementation ESAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)fetchComments:(id)sender
{
    self.isSearching = NO;
    
    __block NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.stackexchange.com/2.1/users/%@/comments?pagesize=0&order=desc&sort=creation&site=%@&filter=!9f8L7EC3I", self.userIDField.stringValue, self.siteAPIKeyField.stringValue]];
    dispatch_queue_t Q = dispatch_queue_create("queue", NULL);
    dispatch_async(Q, ^{
        NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:url] returningResponse:nil error:nil];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.numCommentsLabel.stringValue = dict[@"total"];
        });
        NSMutableArray *array = @[].mutableCopy;
        self.comments = @[];
        BOOL hasMore = YES;
        int page = 0;
        int commentsGotten = 0;
        while (hasMore) {
            page++;
            
            url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.stackexchange.com/2.1/users/%@/comments?pagesize=100&order=desc&sort=creation&site=%@&filter=!)sVg3JxWFJByGqu4AeY6&page=%i", self.userIDField.stringValue, self.siteAPIKeyField.stringValue, page]];
            data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:url] returningResponse:nil error:nil];
            dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            [array addObjectsFromArray:dict[@"items"]];
            commentsGotten += 100;
            if (commentsGotten >= self.numCommentsLabel.intValue) hasMore = NO;
        }
        self.comments = array;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}
#pragma NSTableView stuff
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTableCellView *cell = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    if ([tableColumn.identifier isEqualToString:@"author"])
    {
        cell.textField.stringValue = (self.isSearching) ? self.searchResults[row][@"owner"][@"display_name"] : self.comments[row][@"owner"][@"display_name"];
    }
    else if ([tableColumn.identifier isEqualToString:@"comment"])
    {
        cell.textField.stringValue = (self.isSearching) ? [self.searchResults[row][@"body"] stringByConvertingHTMLToPlainText] : [self.comments[row][@"body"] stringByConvertingHTMLToPlainText];
    }
    return cell;
}
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return (self.isSearching) ? [self.searchResults count] : [self.comments count];
}
- (IBAction)search:(id)sender
{
    self.isSearching = YES;
    
    self.searchResults = @[].mutableCopy;
    
    for (NSDictionary *dict in self.comments) {
        NSString *body = dict[@"body"];
        if ([[body lowercaseString] containsString:[self.searchTextField.stringValue lowercaseString]])
        {
            [self.searchResults addObject:dict];
        }
    }
    [self.tableView reloadData];
}
- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    NSString *url = (self.isSearching) ? self.searchResults[self.tableView.selectedRow][@"link"] : self.comments[self.tableView.selectedRow][@"link"];
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:url]];
    
}
@end
