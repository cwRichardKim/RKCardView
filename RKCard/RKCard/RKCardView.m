//
//  RKCardView.m
//  RKCard
//
//  Created by Richard Kim on 11/5/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//

#import "RKCardView.h"

// Responsive view ratio values
#define CORNER_RATIO 0.015
#define CP_RATIO 0.38
#define PP_RATIO 0.247
#define PP_X_RATIO 0.03
#define PP_Y_RATIO 0.213
#define PP_BUFF 3

@implementation RKCardView {
    UIVisualEffectView *visualEffectView;
}
@synthesize profileImageView;
@synthesize coverImageView;
@synthesize titleLabel;
@synthesize panGestureRecognizer;
@synthesize originalPoint;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
//        panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(beingDragged:)];
        
//        [self addGestureRecognizer:panGestureRecognizer];
    }
    return self;
}

-(void)setupView
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = self.frame.size.width * CORNER_RATIO;
    self.layer.shadowRadius = 3;
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.clipsToBounds = YES;
    [self setupPhotos];
}

-(void)setupPhotos
{
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    UIView *cp_mask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height * CP_RATIO)];
    UIView *pp_mask = [[UIView alloc]initWithFrame:CGRectMake(width * PP_X_RATIO, height * PP_Y_RATIO, height * PP_RATIO, height *PP_RATIO)];
    UIView *pp_circle = [[UIView alloc]initWithFrame:CGRectMake(pp_mask.frame.origin.x - PP_BUFF, pp_mask.frame.origin.y - PP_BUFF, pp_mask.frame.size.width + 2* PP_BUFF, pp_mask.frame.size.height + 2*PP_BUFF)];
    pp_circle.backgroundColor = [UIColor whiteColor];
    pp_circle.layer.cornerRadius = pp_circle.frame.size.height/2;
    pp_mask.layer.cornerRadius = pp_mask.frame.size.height/2;
    cp_mask.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
    
    UIBlurEffect* blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    visualEffectView.frame = cp_mask.frame;
    visualEffectView.alpha = 0;
    
    profileImageView = [[UIImageView alloc]init];
    profileImageView.frame = CGRectMake(0, 0, pp_mask.frame.size.width, pp_mask.frame.size.height);
    coverImageView = [[UIImageView alloc]init];
    coverImageView.frame = cp_mask.frame;
    [coverImageView setContentMode:UIViewContentModeScaleAspectFill];
    
    [cp_mask addSubview:coverImageView];
    [pp_mask addSubview:profileImageView];
    cp_mask.clipsToBounds = YES;
    pp_mask.clipsToBounds = YES;
    
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(pp_circle.frame.origin.x+pp_circle.frame.size.width, cp_mask.frame.size.height + 7, self.frame.size.width, 26)];
    
    [titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20]];
    [titleLabel setTextColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    titleLabel.text = @"Title Label";
   
    [self addSubview:titleLabel];
    [self addSubview:cp_mask];
    [self addSubview:pp_circle];
    [self addSubview:pp_mask];
    [coverImageView addSubview:visualEffectView];
}

-(void)addBlurToCoverPhoto:(BOOL)add
{
    if (add) {
        visualEffectView.alpha = 1;
    } else {
        visualEffectView.alpha = 0;
    }
}

@end
