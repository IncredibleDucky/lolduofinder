//
//  NetworkController.m
//  testing swiping
//
//  Created by Mattthew Bailey on 8/13/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "LeagueNetworkController.h"

static const NSString * apiKey = @"8067b586-d3da-4b55-81d0-78bf5046ee8b";

@implementation LeagueNetworkController

+ (NSString *)baseURL {
    return @"https://na.api.pvp.net/api/lol/na/";
}

+ (NSString *)getSummonerURLWithSummID:(NSString *)summID {
    NSString *urlString = [self baseURL];
    
    urlString = [urlString stringByAppendingString:@"v1.4/summoner/"];
    urlString = [urlString stringByAppendingString:summID];
    
    urlString = [LeagueNetworkController appendURLStringWithAPIKey:urlString];
    return urlString;
}

+ (NSString *)getSummonderURLWithSummName:(NSString *)summName {
    NSString *urlString = [self baseURL];
    
    urlString = [urlString stringByAppendingString:@"v1.4/summoner/by-name/"];
    urlString = [urlString stringByAppendingString:summName];
    
    urlString = [LeagueNetworkController appendURLStringWithAPIKey:urlString];
    NSLog(@"%@", urlString);
    return urlString;
}

+ (NSString *)getLeagueInfoForSummonerURLWithSummoner:(Summoner *)summoner {
    NSString *urlString = [self baseURL];
    urlString = [urlString stringByAppendingString:@"v2.5/league/by-summoner/"];
    urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%@", summoner.summonerID]];
    urlString = [LeagueNetworkController appendURLStringWithAPIKey:urlString];
    
    return urlString;
}

+ (NSString *)getMasteriesForSummonerURLWithSummoner:(Summoner *)summoner{
    
    NSString *urlString = [self baseURL];
    urlString = [urlString stringByAppendingString:@"v1.4/summoner/"];
    urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%@/", summoner.summonerID]];
    urlString = [urlString stringByAppendingString:@"masteries"];
    urlString = [LeagueNetworkController appendURLStringWithAPIKey:urlString];

    return urlString;
}

+ (NSString *)appendURLStringWithAPIKey:(NSString *)urlString {
    
    urlString =  [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
    urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"?api_key=%@", apiKey]];
    
    return urlString;
}


@end
