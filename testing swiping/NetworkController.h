//
//  NetworkController.h
//  testing swiping
//
//  Created by Mattthew Bailey on 8/13/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Summoner.h"

@interface NetworkController : NSObject

+ (NSString *)baseURL;
+ (NSString *)appendURLStringWithAPIKey:(NSString *)urlString;
+ (NSString *)getSummonerURLWithSummID:(NSString *)summID;
+ (NSString *)getSummonderURLWithSummName:(NSString *)summName;
+ (NSString *)getLeagueInfoForSummonerURLWithSummoner:(Summoner *)summoner;




@end
