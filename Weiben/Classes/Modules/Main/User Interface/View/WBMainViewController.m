//
//  WBMainViewController.m
//  Weiben
//
//  Created by wenguang pan on 12/1/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBMainViewController.h"
#import "WBStatisticsDisplayData.h"
#import "WBStatisticsDisplayItem.h"
#import "WBUtility.h"
#import "MBProgressHUD.h"
#import "WBMainBackgroundView.h"
#import "WBBarItemImageView.h"

static NSString* const WBStatisticsCellIdentifier = @"WBStatisticsCell";
static const int tableRowHeight = 60;

@interface WBMainViewController ()
{
    BOOL _postCountChanged;
    WBMainBackgroundView *_backgroundView;
    UIActionSheet *_imagePickerActionSheet;
}

@property (nonatomic, strong) UITableView *postTable;
@property (nonatomic, strong) WBStatisticsDisplayData *data;

//@property (nonatomic, weak) IBOutlet UIImageView *cameraIV;
@property (nonatomic, strong) UIImagePickerController * imagePickerController;

@end

@implementation WBMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // fixed bug that navigation bar covers view
    self.navigationController.navigationBar.translucent = NO;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePostCount) name:[WBUtility postChangedNotification] object:nil];
    
    CGPoint viewOrigin = self.view.frame.origin;
    CGSize viewSize = self.view.frame.size;
    CGFloat tableOriginY = (viewSize.height - tableRowHeight * 3) / 4 * 1;
    CGRect tableFrame = CGRectMake(viewOrigin.x, tableOriginY, viewSize.width, tableRowHeight * 3);
    
    // background view
    
    WBMainBackgroundView *backgroundView = [[WBMainBackgroundView alloc] initWithFrame:self.view.frame];
    backgroundView.backgroundColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
    backgroundView.upX = 0;
    backgroundView.upBlankHeight = tableOriginY;
    backgroundView.downBlankHeight = viewSize.height - tableOriginY - tableFrame.size.height;
    _backgroundView = backgroundView;
    [self.view addSubview:_backgroundView];
    [_backgroundView setNeedsDisplay];
    
    // table
    
    UITableView *tableView;
    tableView = [[UITableView alloc] initWithFrame:tableFrame];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = tableRowHeight;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:WBStatisticsCellIdentifier];
    [self.view addSubview:tableView];
    self.postTable = tableView;
    [self.eventHandler updateView];
    
    UIActionSheet *imagePickerActionSheet  = [[UIActionSheet alloc] init];
    [imagePickerActionSheet addButtonWithTitle:@"拍照"];
    [imagePickerActionSheet addButtonWithTitle:@"从照片库选"];
    [imagePickerActionSheet addButtonWithTitle:@"退出"];
    [imagePickerActionSheet setCancelButtonIndex:2];
    imagePickerActionSheet.delegate = self;
    _imagePickerActionSheet = imagePickerActionSheet ;
    
    UIBarButtonItem *cameraBarItem;
    cameraBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(showImagePickerActionSheet)];
    [self.navigationItem setLeftBarButtonItem:cameraBarItem];
    [self.navigationItem.leftBarButtonItem setEnabled:NO];
    [self initImagePickerController];
    
    UIBarButtonItem *addBarItem;
    addBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(toPosting)];
    [self.navigationItem setRightBarButtonItem:addBarItem];
    
    /*
    WBBarItemImageView *cameraIV = [[WBBarItemImageView alloc] initWithFrame:CGRectMake((viewSize.width - 60 * 2) / 3, viewSize.height - 180, 60, 60)];
    cameraIV.contentMode = UIViewContentModeScaleAspectFill;
    cameraIV.tintColor = [UIColor whiteColor];
    cameraIV.image = [[UIImage imageNamed:@"camera.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    cameraIV.target = self;
    cameraIV.action = @selector(showImagePickerActionSheet);
    [self.view addSubview:cameraIV];
    
    
    WBBarItemImageView *addIV = [[WBBarItemImageView alloc] initWithFrame:CGRectMake(60 + (viewSize.width - 60 * 2) / 3 * 2, viewSize.height - 180, 60, 60)];
    addIV.contentMode = UIViewContentModeScaleAspectFill;
    addIV.tintColor = [UIColor whiteColor];
    addIV.image = [[UIImage imageNamed:@"add.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    addIV.target = self;
    addIV.action = @selector(toPosting);
    [self.view addSubview:addIV];
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"Received memory warning --> Main view controller");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (_postCountChanged)
    {
        [self reload];
        _postCountChanged = NO;
    }
}

- (void)setBarItemsEnabled:(BOOL)enabled
{
    [self.navigationItem.leftBarButtonItem setEnabled:enabled];
    [self.navigationItem.rightBarButtonItem setEnabled:enabled];
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

#pragma mark - WBMainViewInterface

- (void)showStatisticsDisplayData:(WBStatisticsDisplayData *)data
{
    self.data = data;
    [self.postTable reloadData];
}

- (void)reload
{
    [self.eventHandler updateView];
}

- (void)changePostCount
{
    _postCountChanged = YES;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBStatisticsDisplayItem *item = self.data.items[indexPath.row];
    UITableViewCell *cell = [self.postTable dequeueReusableCellWithIdentifier:WBStatisticsCellIdentifier forIndexPath:indexPath];
    
    if (indexPath.row == 0)
    {
        cell.textLabel.text = [NSString stringWithFormat:@" %@ : %lu ", @"时间", (unsigned long)item.postCount];
        cell.imageView.image = [UIImage imageNamed:@"calendar-1.png"];
    }
    else if (indexPath.row == 1)
    {
        cell.textLabel.text = [NSString stringWithFormat:@" %@ : %lu ", @"照片", (unsigned long)item.postCount];
        cell.imageView.image = [UIImage imageNamed:@"photo-1.png"];
    }
    else if (indexPath.row == 2)
    {
        cell.textLabel.text = [NSString stringWithFormat:@" %@ : %lu ", @"星标", (unsigned long)item.postCount];
        cell.imageView.image = [UIImage imageNamed:@"star-1.png"];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0)
        [self.eventHandler toTimelineView];
    else if (indexPath.row == 1)
        [self.eventHandler toPhotosView];
    else if (indexPath.row == 2)
        [self.eventHandler toStarredView];
        
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

#pragma mark - wireframee

- (void)toSettings
{
    [self.eventHandler toSettingsView];
}

- (void)toPosting
{
    [self.eventHandler toPostingView];
}
- (void)toPostingWithImage:(UIImage *)image
{
    [self.eventHandler toPostingViewWithImage:image];
}

@end
