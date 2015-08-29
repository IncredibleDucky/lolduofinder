//
//  AppearanceController.m
//  testing swiping
//
//  Created by Mattthew Bailey on 8/27/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "AppearanceController.h"

@implementation AppearanceController

+ (void)initializeAppearanceDefaults {
    [[UILabel appearance] setFont: [UIFont fontWithName:@"FrizQuadrataFont" size:17]];
    [[UIButton appearance].titleLabel setFont: [UIFont fontWithName:@"FrizQuadrataFont" size:17]];
    [UINavigationBar appearance].titleTextAttributes[@"font"] = [UIFont fontWithName:@"FrizQuadrataFont" size:17];

@end
