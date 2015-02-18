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
@synthesize delegate;
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

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
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
    [cp_mask setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    UIView *pp_mask = [[UIView alloc]initWithFrame:CGRectMake(width * PP_X_RATIO, height * PP_Y_RATIO, height * PP_RATIO, height * PP_RATIO)];
    [pp_mask setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    UIView *pp_circle = [[UIView alloc]initWithFrame:CGRectMake(pp_mask.frame.origin.x - PP_BUFF, pp_mask.frame.origin.y - PP_BUFF, pp_mask.frame.size.width + 2* PP_BUFF, pp_mask.frame.size.height + 2*PP_BUFF)];
    [pp_circle setTranslatesAutoresizingMaskIntoConstraints:NO];
    pp_circle.backgroundColor = [UIColor whiteColor];
    pp_circle.layer.cornerRadius = pp_circle.frame.size.height/2;
    
    pp_mask.layer.cornerRadius = pp_mask.frame.size.height/2;
    cp_mask.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
    
    //    CGFloat cornerRadius = self.layer.cornerRadius;
    //    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cp_mask.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    //    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    //    maskLayer.frame = cp_mask.bounds;
    //    maskLayer.path = maskPath.CGPath;
    //    cp_mask.layer.mask = maskLayer;
    
    
    UIBlurEffect* blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [visualEffectView setTranslatesAutoresizingMaskIntoConstraints:NO];
    visualEffectView.frame = cp_mask.frame;
    visualEffectView.alpha = 0;
    
    profileImageView = [[UIImageView alloc]init];
    [profileImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    profileImageView.frame = CGRectMake(0, 0, pp_mask.frame.size.width, pp_mask.frame.size.height);
    [profileImageView setContentMode:UIViewContentModeScaleAspectFill];
    
    coverImageView = [[UIImageView alloc] init];
    [coverImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    coverImageView.frame = cp_mask.frame;
    [coverImageView setContentMode:UIViewContentModeScaleAspectFill];
    
    [cp_mask addSubview:coverImageView];
    [pp_mask addSubview:profileImageView];
    cp_mask.clipsToBounds = YES;
    pp_mask.clipsToBounds = YES;
    
    // Setup the label
    CGFloat titleLabelX = pp_circle.frame.origin.x + pp_circle.frame.size.width;
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelX - 25, cp_mask.frame.size.height, self.frame.size.width - titleLabelX + 25, 26)];
    [titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    titleLabel.adjustsFontSizeToFitWidth = NO;
    titleLabel.lineBreakMode = NSLineBreakByClipping;
    [titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20]];
    [titleLabel setTextColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.85]];
    [titleLabel setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.85]];
    titleLabel.text = @"Title Label";
    
    // Register touch events on the label
    titleLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelTap)];
    [titleLabel addGestureRecognizer:tapGesture];
    
    // Register touch events on the cover image
    coverImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureCover =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverPhotoTap)];
    [coverImageView addGestureRecognizer:tapGestureCover];
    
    // Register touch events on the profile imate
    profileImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureProfile =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profilePhotoTap)];
    [profileImageView addGestureRecognizer:tapGestureProfile];
    
    // building upp the views
    [self addSubview:titleLabel];
    [self addSubview:cp_mask];
    [self addSubview:pp_circle];
    [self addSubview:pp_mask];
    [coverImageView addSubview:visualEffectView];
    
    
    NSDictionary *nameDict = @{@"cp_mask" : cp_mask, @"pp_mask" : pp_mask, @"titleLabel" : titleLabel, @"coverImageView" : coverImageView, @"profileImageView" : profileImageView, @"visualEffectView" : visualEffectView, @"pp_circle" : pp_circle};
    
    //cover photo constraints
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[cp_mask]-0-|" options:0 metrics:nil views:nameDict]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[cp_mask]" options:0 metrics:nil views:nameDict]];
    [cp_mask addConstraint:[NSLayoutConstraint constraintWithItem:cp_mask attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:(height * CP_RATIO)]];
    
    [cp_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[coverImageView]-0-|" options:0 metrics:nil views:nameDict]];
    [cp_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[coverImageView]-0-|" options:0 metrics:nil views:nameDict]];
    
    [cp_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[visualEffectView]-0-|" options:0 metrics:nil views:nameDict]];
    [cp_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[visualEffectView]-0-|" options:0 metrics:nil views:nameDict]];
    
    //profilePhotoConstraints
    [self addConstraint:[NSLayoutConstraint constraintWithItem:pp_mask attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:(width * PP_X_RATIO)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:pp_mask attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cp_mask attribute:NSLayoutAttributeBottom multiplier:1.0 constant:26]];
    
    [pp_mask addConstraint:[NSLayoutConstraint constraintWithItem:pp_mask attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:(height * PP_RATIO)]];
    [pp_mask addConstraint:[NSLayoutConstraint constraintWithItem:pp_mask attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:(height * PP_RATIO)]];
    
    [pp_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[profileImageView]-0-|" options:0 metrics:nil views:nameDict]];
    [pp_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[profileImageView]-0-|" options:0 metrics:nil views:nameDict]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:pp_circle attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:pp_mask attribute:NSLayoutAttributeLeading multiplier:1.0 constant:(-1.0f * PP_BUFF)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:pp_circle attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:pp_mask attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:(PP_BUFF)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:pp_circle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:pp_mask attribute:NSLayoutAttributeTop multiplier:1.0 constant:(-1.0f * PP_BUFF)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:pp_circle attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:pp_mask attribute:NSLayoutAttributeBottom multiplier:1.0 constant:(PP_BUFF)]];
    
    //titleLabel constraints
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[cp_mask]-0-[titleLabel]" options:0 metrics:nil views:nameDict]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[pp_mask]-(-25)-[titleLabel]-0-|" options:0 metrics:nil views:nameDict]];
    [titleLabel addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:26.0f]];
    
}

/*
 [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[label]-20-|" options:0 metrics:nil views:nameDict]];
 */

-(void)titleLabelTap{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(nameTap)]) {
        [self.delegate nameTap];
    }
}

-(void)coverPhotoTap{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(coverPhotoTap)]) {
        [self.delegate coverPhotoTap];
    }
}

-(void)profilePhotoTap{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(profilePhotoTap)]) {
        [self.delegate profilePhotoTap];
    }
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
