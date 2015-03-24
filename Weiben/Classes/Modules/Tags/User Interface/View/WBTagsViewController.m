//
//  WBTagsViewController.m
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBTagsViewController.h"

@interface WBTagsViewController ()

@property (nonatomic, weak) IBOutlet UIButton *toPostingButton;
@property (nonatomic, weak) IBOutlet UIButton *toDetailButton;

@end

@implementation WBTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toPosting:(id)sender
{
    [self.eventHandler toPostingView];
}
- (IBAction)toDetail:(id)sender
{
    [self.eventHandler toDetailView];
}

@end
