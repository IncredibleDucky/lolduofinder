//
//  SummonerController.m
//  testing swiping
//
//  Created by Mattthew Bailey on 8/14/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "SummonerController.h"
#import "Summoner.h"

#import "LeagueNetworkController.h"

@interface SummonerController ()

@property (strong, nonatomic, readwrite) NSMutableArray *queried;
@property (strong, nonatomic, readwrite) NSMutableArray *potentialMatches;
@property (strong, nonatomic, readwrite) NSMutableArray *pendingMatches;
@property (strong, nonatomic, readwrite) NSMutableArray *matches;
@property (strong, nonatomic, readwrite) NSMutableArray *matchesSummoners;
@property (strong, nonatomic, readwrite) NSMutableArray *denied;
@property (strong, nonatomic, readwrite) NSMutableArray *cards;

@end


@implementation SummonerController

+ (SummonerController *)sharedInstance {
    static SummonerController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [SummonerController new];
        sharedInstance.queried = [NSMutableArray new];
        sharedInstance.matches = [NSMutableArray new];
        sharedInstance.matchesSummoners = [NSMutableArray new];
        sharedInstance.potentialMatches = [NSMutableArray new];
        sharedInstance.denied = [NSMutableArray new];
        sharedInstance.pendingMatches = [NSMutableArray new];
        sharedInstance.cards = [NSMutableArray new];
//Instantiate Shared Instance Properties
    });
    return sharedInstance;
}


@end