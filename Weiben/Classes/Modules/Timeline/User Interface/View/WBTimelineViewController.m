//
//  WBTimelineViewController.m
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBTimelineViewController.h"
#import "WBTimelinePresenter.h"
#import "WBTimelineTableCell.h"
#import "MBProgressHUD.h"
#import "WBPostItem.h"
#import "WBTimelineDisplayItem.h"
#import "UIView+WBUtility.h"
#import "WBUtility.h"

static NSString* const WBTimelineCellIdentifier = @"WBTimelineCell";
static const CGFloat tableRowHeight = 80.0f;

@interface WBTimelineViewController ()
{
    NSDictionary *_postChangedNotificationUserInfo;
}

@property (nonatomic, strong) UITableView *timelineTable;
@property (nonatomic, strong) NSArray *data;

@end

@implementation WBTimelineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // fixed bug that navigation bar covers view
    self.navigationController.navigationBar.translucent = NO;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(respondPostChangedNotification:) name:[WBUtility postChangedNotification] object:nil];
    
    UIBarButtonItem *addBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(toPosting)];
    [self.navigationItem setRightBarButtonItem:addBarItem];
    
    CGRect leftLineRect = CGRectMake(20, 0, 1, self.view.frame.size.height);
    UIView *leftLineView = [[UIView alloc] initWithFrame:leftLineRect];
    leftLineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:leftLineView];
    
    UITableView *tableView;
    CGPoint viewOrigin = self.view.frame.origin;
    CGSize viewSize = self.view.frame.size;
    CGRect tableFrame = CGRectMake(viewOrigin.x, 0, viewSize.width, viewSize.height);
    tableView = [[UITableView alloc] initWithFrame:tableFrame];
    tableView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    tableView.opaque = NO;
    tableView.rowHeight = tableRowHeight;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    self.timelineTable = tableView;
    [self.eventHandler updateView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
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

- (void)refreshTableAfterPostChanged
{
    NSString *action = [_postChangedNotificationUserInfo objectForKey:[WBUtility postChangedAction]];
    if ([action isEqualToString:[WBUtility postChangedActionAdd]])
    {
        WBPostItem *addedItem = [_postChangedNotificationUserInfo objectForKey:[WBUtility postChangedItem]];
        WBTimelineDisplayItem *newDisplayItem = [WBTimelineDisplayItem timelineDisplayItem:addedItem timelineInterval:WBTimelineIntervalInOneDay intervalHead:NO];
        NSMutableArray *array = [NSMutableArray arrayWithArray:_data];
        [array insertObject:newDisplayItem atIndex:1];
        _data = array;
        
        // scroll table to up
        [_timelineTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
    else if ([action isEqualToString:[WBUtility postChangedActionUpdate]])
    {
        WBPostItem *updatedItem = [_postChangedNotificationUserInfo objectForKey:[WBUtility postChangedItem]];
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:_data];
        WBTimelineDisplayItem *displayItem;
        
        for (int i=0; i<[array count]; i++) {
            
            displayItem = array[i];
            if ([displayItem.postItem.identifier isEqualToString:[updatedItem identifier]])
            {
                WBTimelineDisplayItem *updatedDisplayItem = [WBTimelineDisplayItem timelineDisplayItem:updatedItem timelineInterval:displayItem.timelineInterval intervalHead:displayItem.intervalHead];
                [array replaceObjectAtIndex:i withObject:updatedDisplayItem];
                break;
            }
        }
        _data = array;
        
    }
    else if ([action isEqualToString:[WBUtility postChangedActionDelete]])
    {
        NSString *deletedItemID = [_postChangedNotificationUserInfo objectForKey:[WBUtility postDeletedItemID]];
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:_data];
        WBTimelineDisplayItem *displayItem;
        
        for (int i=0; i<[array count]; i++) {
            
            displayItem = array[i];
            if ([displayItem.postItem.identifier isEqualToString:deletedItemID])
            {
                [array removeObjectAtIndex:i];
                break;
            }
        }
        _data = array;
    }
    [_timelineTable reloadData];
}

- (void)showDisplayData:(NSArray *)data
{
    _data = data;
    [_timelineTable reloadData];
}

- (void)reload
{
    [self.eventHandler updateView];
}

- (void)respondPostChangedNotification:(NSNotification *)notification
{
    
    if ([notification.name isEqualToString:[WBUtility postChangedNotification]])
    {
        _postChangedNotificationUserInfo = notification.userInfo;
    }
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
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBTimelineDisplayItem *item = [self.data objectAtIndex:indexPath.row];
    CGFloat height = item.intervalHead ? 44.0f : tableRowHeight;
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBTimelineTableCell *cell;
    cell = [self.timelineTable dequeueReusableCellWithIdentifier:WBTimelineCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[WBTimelineTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:WBTimelineCellIdentifier];
        cell.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        cell.opaque = NO;
    }
    WBTimelineDisplayItem *displayItem = [self.data objectAtIndex:indexPath.row];
    cell.displayItem = displayItem;
    if (displayItem.intervalHead)
    {
        cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    }
    else
    {
        cell.separatorInset = displayItem.intervalTail ? UIEdgeInsetsMake(0, 15, 0, 0) : UIEdgeInsetsMake(0, 25, 0, 0);
    }
    [cell setNeedsDisplay];
    
    // Dad things would come out while scrolling!!
    //if (indexPath.row % 5 == 0)
    //    cell.textLabel.text = @" MARK ";

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBTimelineDisplayItem *displayItem = [self.data objectAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (!displayItem.intervalHead)
    {
        [self toDetail:displayItem.postItem.identifier];
    }
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
