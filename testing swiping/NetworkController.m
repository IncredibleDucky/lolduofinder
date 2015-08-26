//
//  NetworkController.m
//  testing swiping
//
//  Created by Mattthew Bailey on 8/13/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "NetworkController.h"

static const NSString * apiKey = @"77169713-d987-4b15-a5d9-4bde08f92c20";

@implementation NetworkController

+ (NSString *)baseURL {
    return @"https://na.api.pvp.net/api/lol/na/";
}

+ (NSString *)getSummonerURLWithSummID:(NSString *)summID {
    NSString *urlString = [self baseURL];
    
    urlString = [urlString stringByAppendingString:@"v1.4/summoner/"];
    urlString = [urlString stringByAppendingString:summID];
    
    urlString = [NetworkController appendURLStringWithAPIKey:urlString];
    return urlString;
}

+ (NSString *)getSummonderURLWithSummName:(NSString *)summName {
    NSString *urlString = [self baseURL];
    
    urlString = [urlString stringByAppendingString:@"v1.4/summoner/by-name/"];
    urlString = [urlString stringByAppendingString:summName];
    
    urlString = [NetworkController appendURLStringWithAPIKey:urlString];
    NSLog(@"%@", urlString);
    return urlString;
}

+ (NSString *)getLeagueInfoForSummonerURLWithSummoner:(Summoner *)summoner {
    NSString *urlString = [self baseURL];
    urlString = [urlString stringByAppendingString:@"v2.5/league/by-summoner/"];
    urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%@", summoner.summonerID]];
    urlString = [NetworkController appendURLStringWithAPIKey:urlString];
    
    return urlString;
}

+ (NSString *)appendURLStringWithAPIKey:(NSString *)urlString {
    
    urlString =  [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
    urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"?api_key=%@", apiKey]];
    
    return urlString;
}


@end
