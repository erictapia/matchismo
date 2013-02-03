//
//  PlayingCard.h
//  Matchismo
//
//  Created by Eric Tapia on 1/25/13.
//  Copyright (c) 2013 Eric Tapia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card
    @property (strong, nonatomic) NSString *suit;
    @property (nonatomic) NSUInteger rank;

    + (NSArray *)validSuits;
    + (NSUInteger)maxRank;
@end
