//
//  ChampionSkinDictionary.h
//  testing swiping
//
//  Created by Mattthew Bailey on 10/7/15.
//  Copyright © 2015 Richard Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChampionSkinDictionary : NSObject

+ (NSDictionary *)championSkinDictionary;

+ (NSArray *) skinListForChampion:(NSString *)championName;

+ (NSArray *) championList;

@end
