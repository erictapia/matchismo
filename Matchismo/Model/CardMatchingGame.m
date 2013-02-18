//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Eric Tapia on 1/31/13.
//  Copyright (c) 2013 Eric Tapia. All rights reserved.
//

#import "CardMatchingGame.h"
#import "PlayingCard.h"

@interface CardMatchingGame()

// A property containing an array of game "cards"
    @property (strong, nonatomic) NSMutableArray *cards;

// A property containing the current game "score".
    @property (nonatomic, readwrite) int score;

// A property containing the "matchNumberOfCards" required for a match.
    @property (nonatomic) NSUInteger matchNumberOfCards;

/*
    A property containing the last result in a dictionary.
    Keys:   RESULT      - Flipped, Re-Flipped, Matched, Miss-Match
            CARD        - all cards selected
            SCORE       - score added due to result
*/
    @property (nonatomic, readwrite) NSMutableDictionary *lastResult;

@end

@implementation CardMatchingGame


- (NSMutableDictionary *)lastResult {
    
    if (!_lastResult) {
        _lastResult = [NSMutableDictionary dictionary];
    }
    return _lastResult;
}

- (NSMutableArray *)cards {
    if (!_cards)
        _cards = [[NSMutableArray alloc] init];
    
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck matchNumberOfCards:(NSUInteger)matchNumberOfCards {
    self = [super init];
    
    if (self) {
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (!card)
                self = nil;
            else {
                self.cards[i] = card;
            }
        }
        
        // Must match at least 2
        if ( matchNumberOfCards < [CardMatchingGame getMinimumMatchCards]) {
            self.matchNumberOfCards = [CardMatchingGame getMinimumMatchCards];
        } else {
            self.matchNumberOfCards = matchNumberOfCards;
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (NSMutableArray *)getPlayableFaceUpCards {
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    
    // Build array of cards that are faceup and playable.
    for (Card *card in self.cards) {
        if (card.faceUp && !card.unplayable) {
            [cards addObject:card];
        }
    }
    
    return cards;
}


- (void)flipCardAtIndex:(NSUInteger)index {
    
   
    Card *card = [self cardAtIndex:index];
    
    NSString *result = @"Re-Flipped";
    NSInteger scoreResult = 0;
    
    NSMutableArray *otherCards = [NSMutableArray array];
    
    if (!card.faceUp && !card.isUnplayable) {
        result = @"Flipped";
        
        // Another flip, update "score"
        self.score += [CardMatchingGame getFlipCost];
        scoreResult = [CardMatchingGame getFlipCost];
        
        // Get array of cards that are playable and faceup.
        otherCards = [self getPlayableFaceUpCards];
  
        // Are we building or at minimum cards required for matching?
        BOOL enoughCardsToMatch = ([otherCards count] + 1 == [self matchNumberOfCards]) ? YES : NO;
       
        // Check if cards make a match
        int matchScore = [card match:otherCards];
        
        if (matchScore) {
            if (enoughCardsToMatch)  {
                result = @"Match";
                
                for (Card *otherCard in otherCards) {
                    otherCard.unplayable = YES;
                }
                
                self.score += [CardMatchingGame getMatchBonus];
                scoreResult = [CardMatchingGame getMatchBonus];
                card.unplayable = YES;
            } else {
                // Clear othercards for lastFlip
                [otherCards removeAllObjects];
            }

            
        } else {
            // Game rules says these "otherCards" do not match.
            // Make "otherCards" face down.

            result = @"Miss-Match";
            
            for (Card *otherCard in otherCards) {
                otherCard.faceUp = !otherCard.isFaceUp;
            }
            
            self.score += [CardMatchingGame getMismatchPenalty];
            scoreResult = [CardMatchingGame getMismatchPenalty];
        }        
    }
    
    [self.lastResult removeAllObjects];
    
    [self.lastResult setObject:result           forKey:@"RESULT"];      // Object: NSString
    
    [otherCards addObject:card];
    [self.lastResult setObject: otherCards      forKey:@"CARD"];        // Object: Card
    [self.lastResult setObject:@(scoreResult)   forKey:@"SCORE"];       // Object: NSNumber
    
    // Toggle "card" faceup
    card.faceUp = !card.isFaceUp;
}


// CLASS METHODS --------------------------------------------------------

// Score values
#define FLIP_COST -1
#define MISMATCH_PENALTY -2
#define MATCH_BONUS 4
#define MINIMUM_MATCH_CARDS 2

+ (NSInteger) getFlipCost {
    return FLIP_COST;
}

+ (NSInteger) getMismatchPenalty {
    return MISMATCH_PENALTY;
}

+ (NSInteger) getMatchBonus {
    return MATCH_BONUS;
}

+ (NSUInteger) getMinimumMatchCards {
    return MINIMUM_MATCH_CARDS;
}


@end
