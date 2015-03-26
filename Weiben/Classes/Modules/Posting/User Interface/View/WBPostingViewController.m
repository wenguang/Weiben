//
//  WBWritingViewController.m
//  Weiben
//
//  Created by wenguang pan on 11/30/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBPostingViewController.h"
#import "WBUtility.h"
#import "WBPostDisplayData.h"
#import "UIView+WBUtility.h"
#import "WBBarItemImageView.h"
#import "MBProgressHUD.h"
#import "WBDetailBackgroundView.h"
#import "UIImage+WBUtility.h"

@interface WBPostingViewController ()
{
    UITextView *_postingTextView;
    UIScrollView *_contentScrollView;
    WBDetailBackgroundView *_detailBackgroundView;
    
    UIImagePickerController *_imagePickerController;
    
    UIToolbar *_inputToolbar;
    UIActionSheet *_imagePickerActionSheet;
    UIActionSheet *_imageRemoveActionSheet;
    UIBarButtonItem *_imagePickerBarItem;
    UIBarButtonItem *_imageRemoveBarItem;
    UIBarButtonItem *_starBarItem;
    UIBarButtonItem *_unstarBarItem;
    WBBarItemImageView *_removeBarItemImageView;
    
    UIActionSheet *_postRemoveActionSheet;
    CLLocationManager *_locationManager;
    BOOL _appearFromImagePickerOrDisappearByImagePicker;
}

@end

@implementation WBPostingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initImagePickerController];
    [self initInputToolbar];
    
    // fixed bug that navigation bar covers view
    self.navigationController.navigationBar.translucent = NO;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // if will appear from image picker, do nothing.
    if (_appearFromImagePickerOrDisappearByImagePicker)
        return;
    
    //else
    
    if (_mode == WBPostViewModeEditing)
    {
        [self switchToEditMode];
    }
    else if (_mode == WBPostViewModeDetail)
    {
        _displayData = nil;
        [self.eventHandler requestPostWithIdentifier:self.postID];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //if will appear from image picker, reset flag and return
    if (_appearFromImagePickerOrDisappearByImagePicker)
    {
        _appearFromImagePickerOrDisappearByImagePicker = NO;
        return;
    }
    /*
    // else
    if (_mode == WBPostViewModeEditing)
    {
        [self switchToEditMode];
    }
    else if (_mode == WBPostViewModeDetail)
    {
        _displayData = nil;
        [self.eventHandler requestPostWithIdentifier:self.postID];
    }
     */
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // if disappeared by image picker, do nothing.
    if (_appearFromImagePickerOrDisappearByImagePicker)
        return;
    
    // else set _displayData to nil, clean textview
    _displayData = nil;
    _postingTextView.text = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"Received memory warning --> Posting view controller");
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

- (void)setBarItemsEnabled:(BOOL)enabled
{
    [self.navigationItem.leftBarButtonItem setEnabled:enabled];
    [self.navigationItem.rightBarButtonItem setEnabled:enabled];
    [self.navigationItem setHidesBackButton:!enabled animated:YES];
}

#pragma mark - DetailMode

- (void)showDisplayData:(WBPostDisplayData *)displayData
{
    if (displayData)
        _displayData = displayData;
    
    [self switchToDetailMode];
}

- (void)switchToDetailMode
{
    if (_mode != WBPostViewModeDetail)
        _mode = WBPostViewModeDetail;
    
    self.title = @"详细";
    
    // navigation items
    
    [self.navigationItem setLeftBarButtonItem:nil];
    [self.navigationItem setHidesBackButton:NO];
    
    UIBarButtonItem *editBarItem;
    editBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(switchToEditMode)];
    [self.navigationItem setRightBarButtonItem:nil];
    [self.navigationItem setRightBarButtonItem:editBarItem];
    
    // remove all subview
    
    [self.view removeAllSubviews];
    
    // rect relative vars
    
    //CGPoint viewOrigin = self.view.frame.origin;
    CGSize viewSize = self.view.frame.size;
    
    // back ground view
    
    _detailBackgroundView = [[WBDetailBackgroundView alloc] initWithFrame:CGRectMake(0, 0, viewSize.width, viewSize.height) image:_displayData.image imageHeight:300];
    [self.view addSubview:_detailBackgroundView];
    
    // bottom panel
    
    CGFloat bottomPanelHeight = self.navigationController.navigationBar.frame.size.height;
    CGRect bottomPanelRect = CGRectMake(0, viewSize.height - bottomPanelHeight, viewSize.width, bottomPanelHeight);
    UIView *bottomPanel = [[UIView alloc] initWithFrame:bottomPanelRect];
    [bottomPanel setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.9]];
    
    if (!_postRemoveActionSheet)
    {
        UIActionSheet *postRemoveActionSheet = [[UIActionSheet alloc] init];
        [postRemoveActionSheet addButtonWithTitle:@"删除"];
        [postRemoveActionSheet addButtonWithTitle:@"退出"];
        [postRemoveActionSheet setCancelButtonIndex:1];
        postRemoveActionSheet.delegate = self;
        _postRemoveActionSheet = postRemoveActionSheet;
    }
    
    CGFloat deleteButtonHeight = 24;
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [deleteButton setFrame:CGRectMake(10, (bottomPanelHeight - deleteButtonHeight) / 2, deleteButtonHeight, deleteButtonHeight)];
    [deleteButton setTintColor:[UIColor whiteColor]];
    [deleteButton setImage:[[UIImage imageNamed:@"delete-32.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(showPostRemoveActionSheet) forControlEvents:UIControlEventTouchUpInside];
    
    [bottomPanel addSubview:deleteButton];
    [self.view addSubview:bottomPanel];
    
    // content scroll view
    
    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _detailBackgroundView.frame.origin.y, viewSize.width, _detailBackgroundView.frame.size.height - bottomPanel.frame.size.height)];
    
    // calculate contentsize's height
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat minTextContentHeight = screenHeight - bottomPanelRect.size.height;
    CGFloat minScrollContentHeight = _detailBackgroundView.imageHeight + minTextContentHeight;
    
    _contentScrollView.contentSize = CGSizeMake(viewSize.width, minScrollContentHeight);
    _contentScrollView.bounces = NO;
    _contentScrollView.delegate = self;
    [self.view addSubview:_contentScrollView];
    
    // content scroll view's subview - transview (alpha 0.0)
    
    if (_displayData.image)
    {
        UIView *transView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewSize.width, _detailBackgroundView.imageHeight)];
        transView.alpha = 0.0;
        [_contentScrollView addSubview:transView];
    }
    
    // content scroll view's subview - text contentview
    
    UIView *partContentView = [[UIView alloc] initWithFrame:CGRectMake(0, _displayData.image ? _detailBackgroundView.imageHeight : 0, viewSize.width, minTextContentHeight)];
    partContentView.backgroundColor = [UIColor whiteColor];
    [_contentScrollView addSubview:partContentView];
    
    CGFloat floatingY = 0;
    floatingY += 12;    // padding y
    
    CGFloat textFixedWidth = viewSize.width - 40;
    CGFloat textHeight = 0;
    if (_displayData.text && ![_displayData.text isEqualToString:@""])
    {
        CGSize textSize = [_displayData.text sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:20], NSForegroundColorAttributeName : [UIColor blackColor] }];
        textHeight = textSize.height;
        
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(20, floatingY, textFixedWidth, 200)];
        textView.font = [UIFont systemFontOfSize:20];
        textView.textColor = [UIColor blackColor];
        textView.editable = NO;
        textView.scrollEnabled = NO;
        textView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        textView.text = _displayData.text;
        [partContentView addSubview:textView];
    }
    //floatingY += textHeight;    // text height
    floatingY += 200;
    
    floatingY += 12;    // padding y
    
    UIView *seplineView1 = [[UIView alloc] initWithFrame:CGRectMake(20, floatingY, textFixedWidth, 1)];
    seplineView1.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.5];
    [partContentView addSubview:seplineView1];
    
    floatingY += 1;     // 1 is seperator line
    floatingY += 5;     // padding y
    
    CGFloat dateStringHeight;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-mm-dd hh:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:_displayData.date];
    NSAttributedString *dateAttrString = [[NSAttributedString alloc] initWithString:dateString attributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:11], NSForegroundColorAttributeName : [UIColor blackColor] }];
    CGRect dateAttrStringRect = [dateAttrString boundingRectWithSize:CGSizeMake(textFixedWidth - 6, 1000) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) context:nil];
    dateStringHeight = dateAttrStringRect.size.height;
    
    UIImageView *starView = [[UIImageView alloc] initWithFrame:CGRectMake(25, floatingY, dateStringHeight, dateStringHeight)];
    starView.image = [UIImage imageNamed:_displayData.star ? @"fav.png" : @"fav-empty.png"];
    [partContentView addSubview:starView];
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(30 + dateStringHeight, floatingY, textFixedWidth - (30 + dateStringHeight + 5), dateStringHeight)];
    dateLabel.font = [UIFont systemFontOfSize:11];
    dateLabel.textColor = [UIColor grayColor];
    dateLabel.text = dateString;
    [partContentView addSubview:dateLabel];
    
    floatingY += dateStringHeight;  // date string height
    
    floatingY += 5;     // padding y
    
    UIView *seplineView2 = [[UIView alloc] initWithFrame:CGRectMake(20, floatingY, textFixedWidth, 1)];
    seplineView2.backgroundColor = seplineView1.backgroundColor;
    [partContentView addSubview:seplineView2];
    
    floatingY += 1;     // 1 is seperator line
    floatingY += 5;     // padding y
    
    if (_displayData.place && ![_displayData.place isEqualToString:@""])
    {
        UIImageView *pinView = [[UIImageView alloc] initWithFrame:CGRectMake(25, floatingY, dateStringHeight, dateStringHeight)];
        pinView.image = [UIImage imageNamed:@"pin-orange-16.png"];
        [partContentView addSubview:pinView];
        
        UILabel *placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30 + dateStringHeight, floatingY, textFixedWidth - (30 + dateStringHeight + 5), dateStringHeight)];
        placeLabel.font = [UIFont systemFontOfSize:10];
        placeLabel.textColor = [UIColor grayColor];
        placeLabel.text = _displayData.place;
        [partContentView addSubview:placeLabel];
    }
    
    floatingY += dateStringHeight;      // place string's height is equal date's
    
    floatingY += 10;    // padding y
}

#pragma mark - textview delegate

- (void)textViewDidChange:(UITextView *)textView
{
    _displayData.text = textView.text;
}

#pragma mark - content scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;
    if (y >= 0 && y <= _detailBackgroundView.frame.size.height)
    {
        [_detailBackgroundView setImageOffsetY:y];
    }
}

#pragma mark - EditMode

- (void)switchToEditMode
{
    if (_mode != WBPostViewModeEditing)
        _mode = WBPostViewModeEditing;
    
    self.title = @"编辑";
    
    if (!_displayData)
        _displayData = [[WBPostDisplayData alloc] init];
    
    // navigation items
    
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    UIBarButtonItem *cancelBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPost)];
    [self.navigationItem setLeftBarButtonItem:nil];
    [self.navigationItem setLeftBarButtonItem:cancelBarItem];
    
    UIBarButtonItem *saveBarItem;
    saveBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(savePost)];
    [self.navigationItem setRightBarButtonItem:nil];
    [self.navigationItem setRightBarButtonItem:saveBarItem];
    
    // remove all subviews
    
    [self.view removeAllSubviews];
    
    // rect relative vars
    
    float navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGPoint viewOrigin = self.view.frame.origin;
    CGSize viewSize = self.view.frame.size;
    
    // edit view
    
    CGRect textViewFrame = CGRectMake(viewOrigin.x, 5, viewSize.width, viewSize.height - navigationBarHeight);
    UITextView *textView = [[UITextView alloc] initWithFrame:textViewFrame];
    textView.delegate = self;
    [textView setFont:[UIFont systemFontOfSize:18]];
    if (_displayData && _displayData.text)
    {
        [textView setText:_displayData.text];
    }
    [self.view addSubview:textView];
    _postingTextView = textView;
    _postingTextView.inputAccessoryView = [self keyboardToolBar];
    [_postingTextView becomeFirstResponder];
    
    // init locating
    if (!_displayData.place || [_displayData.place isEqualToString:@""])
    {
        [self startLocating];
    }
}

#pragma mark - Custom input accessory

- (void)initInputToolbar
{
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlack];
    [toolbar setTranslucent:YES];
    [toolbar sizeToFit];
    _inputToolbar = toolbar;
    
    UIBarButtonItem *imagePickerBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(showImagePickerActionSheet)];
    imagePickerBarItem.tintColor = [UIColor whiteColor];
    _imagePickerBarItem = imagePickerBarItem;
    
    WBBarItemImageView *removeBarItemImageView = [[WBBarItemImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    removeBarItemImageView.contentMode = UIViewContentModeScaleToFill;
    removeBarItemImageView.target = self;
    removeBarItemImageView.action = @selector(showImageRemoveActionSheet);
    _removeBarItemImageView = removeBarItemImageView;
    
    UIBarButtonItem *imageRemoveBarItem;
    imageRemoveBarItem = [[UIBarButtonItem alloc] initWithCustomView:_removeBarItemImageView];
    _imageRemoveBarItem = imageRemoveBarItem;
    
    UIActionSheet *imagePickerActionSheet  = [[UIActionSheet alloc] init];
    [imagePickerActionSheet addButtonWithTitle:@"拍照"];
    [imagePickerActionSheet addButtonWithTitle:@"从照片库选"];
    [imagePickerActionSheet addButtonWithTitle:@"退出"];
    [imagePickerActionSheet setCancelButtonIndex:2];
    imagePickerActionSheet.delegate = self;
    _imagePickerActionSheet = imagePickerActionSheet;
    
    UIActionSheet *imageRemoveActionSheet = [[UIActionSheet alloc] init];
    [imageRemoveActionSheet addButtonWithTitle:@"删除照片"];
    [imageRemoveActionSheet addButtonWithTitle:@"退出"];
    [imageRemoveActionSheet setCancelButtonIndex:1];
    imageRemoveActionSheet.delegate = self;
    _imageRemoveActionSheet = imageRemoveActionSheet;
    
    UIBarButtonItem *starBarItem;
    WBBarItemImageView *starItemIV = [[WBBarItemImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    starItemIV.contentMode = UIViewContentModeScaleToFill;
    starItemIV.image = [UIImage imageNamed:@"fav.png"];
    starItemIV.target = self;
    starItemIV.action = @selector(switchStar);
    starBarItem = [[UIBarButtonItem alloc] initWithCustomView:starItemIV];
    _starBarItem = starBarItem;
    
    UIBarButtonItem *unstarBarItem;
    WBBarItemImageView *unstarItemIV = [[WBBarItemImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    unstarItemIV.contentMode = UIViewContentModeScaleToFill;
    unstarItemIV.image = [UIImage imageNamed:@"fav-empty.png"];
    unstarItemIV.target = self;
    unstarItemIV.action = @selector(switchStar);
    unstarBarItem = [[UIBarButtonItem alloc] initWithCustomView:unstarItemIV];
    _unstarBarItem = unstarBarItem;

    //[toolbar setItems:@[imagePickerBarItem, starBarItem]];
}

- (UIToolbar *)keyboardToolBar
{
    if (_displayData.image)
    {
        
        _removeBarItemImageView.image = [_displayData.image imageByScalingAndCroppingForSize:CGSizeMake(32, 32)];
        if (_displayData.star)
        {
            [_inputToolbar setItems:@[_imageRemoveBarItem, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], _starBarItem]];
        }
        else
        {
            [_inputToolbar setItems:@[_imageRemoveBarItem, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], _unstarBarItem]];
        }
    }
    else
    {
        if (_displayData.star)
        {
            [_inputToolbar setItems:@[_imagePickerBarItem, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], _starBarItem]];
        }
        else
        {
            [_inputToolbar setItems:@[_imagePickerBarItem, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], _unstarBarItem]];
        }
    }
    return _inputToolbar;
}

- (void)switchStar
{
    _displayData.star = !_displayData.star;
    _postingTextView.inputAccessoryView = [self keyboardToolBar];
}

#pragma mark - Picture picker

- (void)initImagePickerController
{
    if (_imagePickerController == nil)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                       {
                           UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                           imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
                           imagePickerController.delegate = self;
                           
                           _imagePickerController = imagePickerController;
                       });
    }
}

#pragma mark - Sheet Actions

- (void)showPostRemoveActionSheet
{
    [_postRemoveActionSheet showInView:self.view];
}

- (void)showImagePickerActionSheet
{
    [_imagePickerActionSheet showInView:self.view];
}
- (void)showImageRemoveActionSheet
{
    [_imageRemoveActionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([actionSheet isEqual:_imagePickerActionSheet])
    {
        switch (buttonIndex)
        {
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
    else if ([actionSheet isEqual:_imageRemoveActionSheet])
    {
        switch (buttonIndex)
        {
            case 0:
                _displayData.image = nil;
                _postingTextView.inputAccessoryView = [self keyboardToolBar];
                break;
                
            default:
                break;
        }
    }
    else if ([actionSheet isEqual:_postRemoveActionSheet])
    {
        switch (buttonIndex)
        {
            case 0:
                [self deletePost];
                break;
                
            default:
                break;
        }
    }
}

- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{
    _imagePickerController.sourceType = sourceType;
    
    if (sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        _imagePickerController.showsCameraControls = YES;
    }
    
    // set flag mean cover by image picker
    _appearFromImagePickerOrDisappearByImagePicker = YES;
    
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    _displayData.image = image;
    [self dismissViewControllerAnimated:YES completion:NULL];
    _postingTextView.inputAccessoryView = [self keyboardToolBar];
    [_postingTextView becomeFirstResponder];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Location & CLLoactionManagerDelegate

- (void)startLocating
{
    if (!_locationManager)
    {
        CLLocationManager *locationManager = [[CLLocationManager alloc] init];
        locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        locationManager.distanceFilter=kCLDistanceFilterNone;
        locationManager.delegate=self;
        _locationManager = locationManager;
    }
    [_locationManager startUpdatingLocation];
}

- (void)stopLocating
{
    if (_locationManager)
        [_locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (locations && locations.count > 0)
    {
        _displayData.location = locations[0];
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:locations[0] completionHandler:^(NSArray *placemarks, NSError *error){
            
            CLPlacemark *placemark = placemarks[0];
            _displayData.place = [WBUtility stringForPlacemark:placemark];
            if (_displayData.place && ![_displayData.place isEqualToString:@""])
            {
                [_locationManager stopUpdatingLocation];
            }
         }];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}

#pragma mark - Handler events

- (void)savePost
{
    [_postingTextView resignFirstResponder];
    
    if (_displayData.identifier)
    {
        [self.eventHandler updatePost:_displayData];
    }
    else
    {
        [self.eventHandler savePostWithText:_postingTextView.text tags:nil image:_displayData.image star:_displayData.star location:_displayData.location place:_displayData.place];
    }
    //[self stopLocating];
}

- (void)cancelPost
{
    [self.eventHandler cancelPost];
}

- (void)deletePost
{
    [self.eventHandler deletePost:_displayData.identifier];
}

- (void)currentPostDeleted
{
    _displayData = nil;
    [self cancelPost];
    
}

#pragma mark - WBPostingViewInterface

- (void)preImage:(UIImage *)image
{
    if (_displayData == nil)
        _displayData = [[WBPostDisplayData alloc] init];
    _displayData.image = image;
}

@end
