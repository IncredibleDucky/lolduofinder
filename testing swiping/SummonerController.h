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
@property (nonatomic, strong, readonly) NSArray *queried;
@property (nonatomic, strong, readonly) NSArray *potentialMatches;
@property (nonatomic, strong, readonly) NSArray *matches;
@property (nonatomic, strong, readonly) NSArray *matchesSummoners;
@property (nonatomic, strong, readonly) NSArray *denied;
@property (nonatomic, strong, readonly) NSArray *pendingMatches;
@property (strong, nonatomic, readonly) NSArray *cards;
@property (nonatomic) BOOL isLoggedIn;


@property (strong, nonatomic) Summoner *summoner;

- (void)setMatchesSummoners:(NSArray *)matchesSummoners;

- (void)setQueried:(NSArray *)queried;

- (void)setMatches:(NSArray *)matches;

- (void)setPotentialMatches:(NSArray *)potentialMatches;

- (void)setDenied:(NSArray *)denied;

- (void)setCards:(NSArray *)cards;

- (void)setPendingMatches:(NSArray *)pendingMatches;
@end
