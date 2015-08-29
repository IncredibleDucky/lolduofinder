//
//  SummonerController.h
//  testing swiping
//
//  Created by Mattthew Bailey on 8/14/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//
#import "Summoner.h"
#import <Foundation/Foundation.h>

@interface SummonerController : NSObject



+ (SummonerController *)sharedInstance;



@property (strong, nonatomic) Summoner *summoner;


@end
