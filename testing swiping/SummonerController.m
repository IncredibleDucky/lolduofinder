//
//  SummonerController.m
//  testing swiping
//
//  Created by Mattthew Bailey on 8/14/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "SummonerController.h"
#import "Summoner.h"

#import "NetworkController.h"

@interface SummonerController ()

@property (strong, nonatomic, readwrite) NSMutableArray *leftSwipes;
@property (strong, nonatomic, readwrite) NSMutableArray *rightSwipes;
@property (strong, nonatomic, readwrite) NSMutableArray *matches;

@end


@implementation SummonerController

+ (SummonerController *)sharedInstance {
    static SummonerController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [SummonerController new];
 //Instantiate Shared Instance Properties
    });
    return sharedInstance;
}

#pragma mark - Create


#pragma mark - Retrieve


#pragma mark - Update


#pragma mark - Delete


@end