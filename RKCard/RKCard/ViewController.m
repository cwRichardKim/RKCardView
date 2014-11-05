//
//  ViewController.m
//  RKCard
//
//  Created by Richard Kim on 11/5/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//

#import "ViewController.h"
#import "RKCardView.h"

#define BUFFERX 20
#define BUFFERY 40

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    RKCardView* view = [[RKCardView alloc]initWithFrame:CGRectMake(BUFFERX, BUFFERY, self.view.frame.size.width-2*BUFFERX, self.view.frame.size.height-2*BUFFERY)];
    view.backgroundColor = [UIColor whiteColor];
    view.coverImageView.image = [UIImage imageNamed:@"exampleCover"];
    view.profileImageView.image = [UIImage imageNamed:@"exampleProfile"];
    view.titleLabel.text = @"Richard Kim";
//    [view addBlurToCoverPhoto:YES];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
