//
//  RKCardView.h
//  RKCard
//
//  Created by Richard Kim on 11/5/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKCardView : UIView

@property (nonatomic)UIImageView *profileImageView;
@property (nonatomic)UIImageView *coverImageView;
@property (nonatomic)UILabel *titleLabel;

- (void)addBlur;
- (void)removeBlur;
- (void)addShadow;
- (void)removeShadow;

@end
