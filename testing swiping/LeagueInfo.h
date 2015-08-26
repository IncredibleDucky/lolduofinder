//
//  LeagueInfo.h
//  testing swiping
//
//  Created by Mattthew Bailey on 8/14/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LeagueInfo : NSObject

@property (nonatomic) NSNumber *leaguePoints;
@property (nonatomic) NSString *division; //Possibly Enum values.
@property (nonatomic) NSString *tier;
@property (nonatomic) NSNumber *wins;
@property (nonatomic) NSNumber *losses;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end
