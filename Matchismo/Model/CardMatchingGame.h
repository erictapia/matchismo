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

// A property containing the current game "score".
    @property (nonatomic, readonly) int score;

// designated initializer where "cardCount" is the number of cards required from the supplied
// "deck", and required number of cards to be considered a match.
    - (id) initWithCardCount:(NSUInteger)cardCount
                   usingDeck:(Deck *)deck
          matchNumberOfCards:(NSUInteger)matchNumberOfCards;

// A method to flip a card at "index".
    - (void) flipCardAtIndex:(NSUInteger)index;

// A method to return a card from the cards at "index".
    - (Card *) cardAtIndex:(NSUInteger)index;

/*
 A property containing the last result in a dictionary.
 Keys:   RESULT      - Flipped, Re-Flipped, Matched, Miss-Match
 CARD        - all cards selected
 SCORE       - score added due to result
 */
    @property (nonatomic, readonly) NSMutableDictionary *lastResult;

@end
