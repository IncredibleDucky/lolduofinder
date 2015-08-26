//
//  LeagueInfo.m
//  testing swiping
//
//  Created by Mattthew Bailey on 8/14/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "LeagueInfo.h"

@implementation LeagueInfo

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if(dictionary[@"tier"]) {
        self.tier = dictionary[@"tier"];
    }
    NSNumber *participantID = nil;
    NSDictionary *leagueData = [NSDictionary new];
    if(dictionary[@"participantId"]) {
        participantID = dictionary[@"participantId"];
    }
    
    if (participantID) {
        NSArray *league = dictionary[@"entries"];
        for (int i = 0; i < league.count; i ++)
        {
            NSNumber *comparisonID = league[i][@"playerOrTeamId"];
            if([participantID isEqual: comparisonID]) {
                leagueData = league[i];
            }
            
        }
    }
    
    if(leagueData[@"division"]) {
        self.division = leagueData[@"division"];
    }
    if(leagueData[@"leaguePoints"]) {
        self.leaguePoints = (NSNumber *)leagueData[@"leaguePoints"];
    }
    if(leagueData[@"wins"]) {
        self.rankedWins = leagueData[@"wins"];
    }
    if(leagueData[@"losses"]) {
        self.losses = leagueData[@"losses"];
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary completion:(void (^)(void))completion {
    
    self = [super init];
    
    if(self) {
        
        if(dictionary[@"id"]) {
            self.summID = dictionary[@"id"];
        }
        if(dictionary[@"name"]) {
            self.name = dictionary[@"name"];
        }
        if(dictionary[@"profileIconId"]) {
            self.profilIconID = dictionary[@"profileIconId"];
        }
        if(dictionary[@"revisionDate"]) {
            self.revisionDate = (NSDate *)dictionary[@"revisionDate"];
        }
        if(dictionary[@"summonerLevel"]) {
            self.summLevel = dictionary[@"summonerLevel"];
        }
        if(dictionary[@"id"]) {
            [self getLeagueInfo:self completion:^{
                completion();
            }];
            
        }
    }
    return self;
}

+ (void)getSummonerWithSummonerName:(NSString *)summonerName completion:(void (^)(void))completion {
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *path = [NSURL URLWithString:[NetworkController getSummonderURLWithSummName:summonerName]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:path completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            completion();
        }
        else {
            NSLog(@"%@", data);
            
            NSError *serializationError;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&serializationError];
            
            NSLog(@"%@", responseDictionary);
            
            NSString *summonerNameKey = [summonerName lowercaseString];
            summonerNameKey = [summonerNameKey stringByReplacingOccurrencesOfString:@" " withString:@""];
            [SummonerController sharedInstance].summoner = [[Summoner alloc] initWithDictionary:responseDictionary[summonerNameKey] completion:^{
                completion();
            }];
            
        }
        
        
    }];
    
    
    [dataTask resume];
    
}



- (void)getLeagueInfo:(Summoner *)summoner completion:(void (^)(void))completion {
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *path = [NSURL URLWithString:[NetworkController getLeagueInfoForSummonerURLWithSummoner:self]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:path completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        }
        else {
            //  NSLog(@"%@", data);
            
            NSError *serializationError;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&serializationError];
            
            //  NSLog(@"%@", responseDictionary);
            
            [SummonerController sharedInstance].summoner.leagueInfo = [[LeagueInfo alloc] initWithDictionary:responseDictionary[self.stringSummID][0]];
            
        }
        completion();
    }];
    [dataTask resume];
    
}

- (NSString *)stringSummID {
    return [self.summID stringValue];
}

-(NSString *)leagueSpecificImageNameForSummoner{
    
    NSMutableString *imageName = [NSMutableString new];
    
    [imageName appendString:self.leagueInfo.tier];
    
    if(![self.leagueInfo.tier isEqualToString:@"CHALLENGER"] && ![self.leagueInfo.tier isEqualToString:@"MASTER"]) {
        [imageName appendString:@"_"];
        [imageName appendString:self.leagueInfo.division];
    }
    
    [imageName appendString:@".png"];
    
    
    
    return [imageName lowercaseString];
    
}


@end
