//
//  lolLabel.m
//  testing swiping
//
//  Created by Mattthew Bailey on 8/27/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "LOLLabel.h"

@implementation LOLLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.font = [UIFont fontWithName:@"FrizQuadrataFont" size:17];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.font = [UIFont fontWithName:@"FrizQuadrataFont" size:17];
    }
    return self;
}

@end
