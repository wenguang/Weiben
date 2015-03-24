//
//  WBPhotosViewController.m
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBPhotosViewController.h"
#import "WBPostItem.h"
#import "WBUtility.h"
#import "MBProgressHUD.h"
#import "UIView+WBUtility.h"
#import "WBPhotoTableCell.h"
#import "WBPhotoDisplayItem.h"

static NSString *PHOTO_CELL = @"PHOTO_CELL";

@interface WBPhotosViewController ()
{
    NSDictionary *_postChangedNotificationUserInfo;
    UIActionSheet *_imagePickerActionSheet;
}

@property (nonatomic, strong) UITableView *photoTable;
@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) UIImagePickerController * imagePickerController;

@end

@implementation WBPhotosViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // fixed bug that navigation bar covers view
    self.navigationController.navigationBar.translucent = NO;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(respondPostChangedNotification:) name:[WBUtility postChangedNotification] object:nil];
    
    UIBarButtonItem *cameraBarItem;
    cameraBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(showImagePickerActionSheet)];
    [self.navigationItem setRightBarButtonItem:cameraBarItem];
    
    UIActionSheet *imagePickerActionSheet  = [[UIActionSheet alloc] init];
    [imagePickerActionSheet addButtonWithTitle:@"拍照"];
    [imagePickerActionSheet addButtonWithTitle:@"从照片库选"];
    [imagePickerActionSheet addButtonWithTitle:@"退出"];
    [imagePickerActionSheet setCancelButtonIndex:2];
    imagePickerActionSheet.delegate = self;
    _imagePickerActionSheet = imagePickerActionSheet ;
    
    [self initImagePickerController];
    
    UITableView *tableView;
    CGPoint viewOrigin = self.view.frame.origin;
    CGSize viewSize = self.view.frame.size;
    CGRect tableFrame = CGRectMake(viewOrigin.x, 0, viewSize.width, viewSize.height);
    tableView = [[UITableView alloc] initWithFrame:tableFrame];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[WBPhotoTableCell class] forCellReuseIdentifier:PHOTO_CELL];
    [self.view addSubview:tableView];
    self.photoTable = tableView;

    [self.eventHandler updateView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"Received memory warning --> Photo view controller");
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
        // refresh table
        [self refreshTableAfterPostChanged];
        
        _postChangedNotificationUserInfo = nil;
    }
}

- (void)showPosts:(NSArray *)posts
{
    self.data = posts;
    [self.photoTable reloadData];
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

- (void)refreshTableAfterPostChanged
{
    NSString *action = [_postChangedNotificationUserInfo objectForKey:[WBUtility postChangedAction]];
    if ([action isEqualToString:[WBUtility postChangedActionAdd]])
    {
        WBPostItem *addedItem = [_postChangedNotificationUserInfo objectForKey:[WBUtility postChangedItem]];
        
        if (addedItem.image)
        {
            NSMutableArray *array = [NSMutableArray arrayWithArray:_data];
            [array insertObject:[WBPhotoDisplayItem itemWithPostItem:addedItem scaleSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 250)] atIndex:0];
            _data = array;
            
            // scroll table to up
            [_photoTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            
            [_photoTable reloadData];
        }
    }
    else if ([action isEqualToString:[WBUtility postChangedActionUpdate]])
    {
        WBPostItem *updatedItem = [_postChangedNotificationUserInfo objectForKey:[WBUtility postChangedItem]];
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:_data];
        WBPhotoDisplayItem *displayItem;
        
        for (int i=0; i<[array count]; i++) {
            
            displayItem = array[i];
            if ([displayItem.postItem.identifier isEqualToString:[updatedItem identifier]])
            {
                updatedItem.image ? [array replaceObjectAtIndex:i withObject:[WBPhotoDisplayItem itemWithPostItem:updatedItem scaleSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 250)]] : [array removeObjectAtIndex:i];
                break;
            }
        }
        _data = array;
        [_photoTable reloadData];
    }
    else if ([action isEqualToString:[WBUtility postChangedActionDelete]])
    {
        NSString *deletedItemID = [_postChangedNotificationUserInfo objectForKey:[WBUtility postDeletedItemID]];
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:_data];
        WBPhotoDisplayItem *displayItem;
        
        for (int i=0; i<[array count]; i++) {
            
            displayItem = array[i];
            if ([displayItem.postItem.identifier isEqualToString:deletedItemID])
            {
                [array removeObjectAtIndex:i];
                break;
            }
        }
        _data = array;
        [_photoTable reloadData];
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

#pragma mark - UITableViewDataSource & UITableViewDelegate
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBPhotoDisplayItem *displayItem = (WBPhotoDisplayItem *)[self.data objectAtIndex:indexPath.row];
    WBPhotoTableCell *cell = [self.photoTable dequeueReusableCellWithIdentifier:PHOTO_CELL];
    
    // if don't set background color, cell would be blank!!!
    cell.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];

    cell.displayItem = displayItem;
    [cell setNeedsDisplay];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBPhotoDisplayItem *displayItem = [self.data objectAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self toDetail:displayItem.postItem.identifier];
}

#pragma mark - Picture picker

- (void)showImagePickerActionSheet
{
    [_imagePickerActionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
            break;
        case 1:
            [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            break;
        default:
            break;
    }
}

- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{
    _imagePickerController.sourceType = sourceType;
    
    if (sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        _imagePickerController.showsCameraControls = YES;
    }
    
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}


- (void)initImagePickerController
{
    if (self.imagePickerController == nil)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
            imagePickerController.delegate = self;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.imagePickerController = imagePickerController;
                [self.navigationItem.leftBarButtonItem setEnabled:YES];
            });
        });
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self toPostingWithImage:image];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - wireframe

- (void)toPostingWithImage:(UIImage *)image
{
    [self.eventHandler toPostingViewWithImage:image];
}

- (void)toDetail:(NSString *)postID
{
    [self.eventHandler toDetailView:postID];
}

@end
