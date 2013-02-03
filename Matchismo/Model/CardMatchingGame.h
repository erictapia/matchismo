//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Eric Tapia on 1/31/13.
//  Copyright (c) 2013 Eric Tapia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject
    @property (nonatomic, readonly) NSString *lastMatchAttempt;
    @property (nonatomic, readonly) int score;

    // designated initializer
    - (id) initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck matchNumberOfCards:(NSUInteger)matchNumberOfCards;
    - (void) flipCardAtIndex:(NSUInteger)index;
    - (Card *) cardAtIndex:(NSUInteger)index;
@end
