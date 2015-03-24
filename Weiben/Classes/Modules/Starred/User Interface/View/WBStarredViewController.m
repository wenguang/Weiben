//
//  WBStarredViewController.m
//  Weiben
//
//  Created by wenguang pan on 1/29/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import "WBStarredViewController.h"
#import "WBPostItem.h"
#import "MGSwipeButton.h"
#import "WBSwipeTableCell.h"
#import "WBUtility.h"
#import "MBProgressHUD.h"
#import "UIView+WBUtility.h"
#import "WBStarredTableCell.h"
#import "WBStarredDisplayItem.h"

static NSString* const WBStarredCellIdentifier = @"WBStarredCell";

@interface WBStarredViewController ()
{
    NSDictionary *_postChangedNotificationUserInfo;
}

@property (nonatomic, strong) UITableView *postTable;
@property (nonatomic, strong) NSArray *data;

@end

@implementation WBStarredViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *addBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(toPosting)];
    [self.navigationItem setRightBarButtonItem:addBarItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(respondPostChangedNotification:) name:[WBUtility postChangedNotification] object:nil];
    
    UITableView *tableView;
    CGPoint viewOrigin = self.view.frame.origin;
    CGSize viewSize = self.view.frame.size;
    CGRect tableFrame = CGRectMake(viewOrigin.x, 0, viewSize.width, viewSize.height);
    tableView = [[UITableView alloc] initWithFrame:tableFrame];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = 80;
    [self.view addSubview:tableView];
    
    // fixed bug that navigation bar covers view
    self.navigationController.navigationBar.translucent = NO;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    
    self.postTable = tableView;
    [self.eventHandler updateView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"Received memory warning --> Star view controller");
}

- (void)viewWillAppear:(BOOL)animated
{
    //[self.eventHandler updateView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (_postChangedNotificationUserInfo)
    {
        // frush table's data
        [self refreshTableAfterPostChanged];
        
        _postChangedNotificationUserInfo = nil;
    }
}

- (void)respondPostChangedNotification:(NSNotification *)notification
{
    
    if ([notification.name isEqualToString:[WBUtility postChangedNotification]])
    {
        _postChangedNotificationUserInfo = notification.userInfo;
    }
}

- (void)refreshTableAfterPostChanged
{
    NSString *action = [_postChangedNotificationUserInfo objectForKey:[WBUtility postChangedAction]];
    if ([action isEqualToString:[WBUtility postChangedActionAdd]])
    {
        WBPostItem *addedItem = [_postChangedNotificationUserInfo objectForKey:[WBUtility postChangedItem]];
        
        if (addedItem.star)
        {
            NSMutableArray *array = [NSMutableArray arrayWithArray:_data];
            [array insertObject:[WBStarredDisplayItem itemWithPostItem:addedItem scaleSize:CGSizeMake(66, 66)] atIndex:0];
            _data = array;
            
            // scroll table to up
            [_postTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            
            [_postTable reloadData];
        }
    }
    else if ([action isEqualToString:[WBUtility postChangedActionUpdate]])
    {
        WBPostItem *updatedItem = [_postChangedNotificationUserInfo objectForKey:[WBUtility postChangedItem]];
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:_data];
        WBStarredDisplayItem *displayItem;
        
        for (int i=0; i<[array count]; i++) {
            
            displayItem = array[i];
            if ([displayItem.postItem.identifier isEqualToString:[updatedItem identifier]])
            {
                updatedItem.star ? [array replaceObjectAtIndex:i withObject:[WBStarredDisplayItem itemWithPostItem:updatedItem scaleSize:CGSizeMake(66, 66)]] : [array removeObjectAtIndex:i];
                break;
            }
        }
        _data = array;
        [_postTable reloadData];
        
    }
    else if ([action isEqualToString:[WBUtility postChangedActionDelete]])
    {
        NSString *deletedItemID = [_postChangedNotificationUserInfo objectForKey:[WBUtility postDeletedItemID]];
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:_data];
        WBStarredDisplayItem *displayItem;
        
        for (int i=0; i<[array count]; i++) {
            
            displayItem = array[i];
            if ([displayItem.postItem.identifier isEqualToString:deletedItemID])
            {
                [array removeObjectAtIndex:i];
                break;
            }
        }
        _data = array;
        [_postTable reloadData];
    }
}

- (void)showPosts:(NSArray *)posts
{
    self.data = posts;
    [self.postTable reloadData];
}

- (void)reload
{
    [self.eventHandler updateView];
}

#pragma mark - HUD

- (void)showHUD
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hideHUD
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark - table datasource & delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBStarredDisplayItem *displayItem = [self.data objectAtIndex:indexPath.row];
    WBStarredTableCell *cell;
    cell = [self.postTable dequeueReusableCellWithIdentifier:WBStarredCellIdentifier];
    if (cell == nil)
    {
        cell = [[WBStarredTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:WBStarredCellIdentifier];
        cell.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    }
    
    cell.displayItem = displayItem;
    [cell setNeedsDisplay];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBStarredDisplayItem *displayItem = [self.data objectAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self toDetail:displayItem.postItem.identifier];
}

#pragma mark - MGSwipeTable

-(NSArray*) swipeTableCell:(MGSwipeTableCell*) cell swipeButtonsForDirection:(MGSwipeDirection)direction
             swipeSettings:(MGSwipeSettings*) swipeSettings expansionSettings:(MGSwipeExpansionSettings*) expansionSettings;
{
    return [self createRightButtons:1];
}


-(NSArray *) createRightButtons: (int) number
{
    NSMutableArray * result = [NSMutableArray array];
    NSString* titles[2] = {@"Delete", @"More"};
    UIColor * colors[2] = {[UIColor redColor], [UIColor lightGrayColor]};
    for (int i = 0; i < number; ++i)
    {
        MGSwipeButton * button = [MGSwipeButton buttonWithTitle:titles[i] backgroundColor:colors[i] callback:^BOOL(MGSwipeTableCell * sender){
            NSLog(@"Convenience callback received (right).");
            
            //NSIndexPath * path = [self.postTable indexPathForCell:sender];
            //[self.eventHandler removePostItem:sender.postID];
            
            //[self.postTable deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationLeft];
            //[self.eventHandler updateView];
            return YES;
        }];
        [result addObject:button];
    }
    return result;
}

-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion
{
    NSLog(@"Delegate: button tapped, %@ position, index %d, from Expansion: %@",
          direction == MGSwipeDirectionLeftToRight ? @"left" : @"right", (int)index, fromExpansion ? @"YES" : @"NO");
    
    if (direction == MGSwipeDirectionRightToLeft && index == 0) {
        //delete button
        NSIndexPath * path = [self.postTable indexPathForCell:cell];
        
        NSArray *deleteIndexPaths = [NSArray arrayWithObjects:
                                     [NSIndexPath indexPathForRow:path.row inSection:0],
                                     nil];
        [self.postTable beginUpdates];
        [self.postTable deleteRowsAtIndexPaths:deleteIndexPaths withRowAnimation:UITableViewRowAnimationLeft];
        [self.postTable endUpdates];
    }
    
    return YES;
}

#pragma mark - wireframe

- (void)toPosting
{
    [self.eventHandler toPostingView];
}

- (void)toDetail:(NSString *)postID
{
    [self.eventHandler toDetailView:postID];
}

@end
