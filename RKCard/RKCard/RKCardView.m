//
//  RKCardView.m
//  RKCard
//
//  Created by Richard Kim on 11/5/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//

/*
 
 Copyright (c) 2014 Choong-Won Richard Kim <cwrichardkim@gmail.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is furnished
 to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 */

#import "RKCardView.h"

// Responsive view ratio values
#define CORNER_RATIO 0.015
#define CP_RATIO 0.38
#define PP_RATIO 0.247
#define PP_X_RATIO 0.03
#define PP_Y_RATIO 0.213
#define PP_BUFF 3
#define LABEL_Y_RATIO .012

@implementation RKCardView {
    UIVisualEffectView *visualEffectView;
}
@synthesize profileImageView;
@synthesize coverImageView;
@synthesize titleLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)addShadow
{
    self.layer.shadowOpacity = 0.15;
}

- (void)removeShadow
{
    self.layer.shadowOpacity = 0;
}

-(void)setupView
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = self.frame.size.width * CORNER_RATIO;
    self.layer.shadowRadius = 3;
    self.layer.shadowOpacity = 0;
    self.layer.shadowOffset = CGSizeMake(1, 1);
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
    
    CGFloat cornerRadius = self.layer.cornerRadius;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cp_mask.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = cp_mask.bounds;
    maskLayer.path = maskPath.CGPath;
    cp_mask.layer.mask = maskLayer;
    
    
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
    
    CGFloat titleLabelX = pp_circle.frame.origin.x+pp_circle.frame.size.width;
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabelX, cp_mask.frame.size.height + 7, self.frame.size.width - titleLabelX, 26)];
    titleLabel.adjustsFontSizeToFitWidth = NO;
    titleLabel.lineBreakMode = NSLineBreakByClipping;
    
    [titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20]];
    [titleLabel setTextColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    titleLabel.text = @"Title Label";
   
    [self addSubview:titleLabel];
    [self addSubview:cp_mask];
    [self addSubview:pp_circle];
    [self addSubview:pp_mask];
    [coverImageView addSubview:visualEffectView];
}

-(void)addBlur
{
    visualEffectView.alpha = 1;
}

-(void)removeBlur
{
    visualEffectView.alpha = 0;
}

@end
