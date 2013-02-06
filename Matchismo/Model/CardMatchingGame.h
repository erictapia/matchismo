//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Eric Tapia on 1/31/13.
//  Copyright (c) 2013 Eric Tapia. All rights reserved.
//

/*
    Description: A  N card matching game where N can be any number greater than two. 
*/

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// A property containing the "history" of the last flipped card result.
    @property (nonatomic, readonly) NSString *history;

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

// A method to check if game is over.
    - (BOOL)isGameOver;
@end
