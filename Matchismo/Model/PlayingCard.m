//
//  PlayingCard.m
//  Matchismo
//
//  Created by Eric Tapia on 1/25/13.
//  Copyright (c) 2013 Eric Tapia. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents {
    return [[PlayingCard rankStrings ][self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;  // because we provide setter and getter

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit])
        _suit = suit;
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank])
        _rank = rank;
}


- (int)match:(NSArray *)otherCards {
    int suitMatched = 0;
    int rankMatched = 0;
    int otherCardsCount = [otherCards count];
    
    if (otherCardsCount) {
        for(PlayingCard *otherCard in otherCards) {
            rankMatched += (self.rank == otherCard.rank) ? 1 : 0;
            suitMatched += (self.suit == otherCard.suit) ? 1 : 0;
        }
    }
 
    return (rankMatched == otherCardsCount) || ( suitMatched == otherCardsCount ) ? 1 : 0;
}


// CLASS METHODS --------------------------------------------------------

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] - 1;
}

+ (NSArray *)validSuits {
    return @[@"♥",@"♦",@"♠",@"♣"];
}

+ (NSArray *)rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

@end
