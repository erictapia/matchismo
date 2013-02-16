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

// A property containing the last flipped card result.
    @property (nonatomic, readwrite) NSString *lastFlipResult;

@end

@implementation CardMatchingGame

- (NSString *)lastFlipResult {
    return _lastFlipResult ? _lastFlipResult : @"";;
}

- (NSMutableArray *)cards {
    if (!_cards)
        _cards = [[NSMutableArray alloc] init];
    
    return _cards;
}

/*
    This method checks the state of the game.  When the game is over, a "YES" is returned otherwise
    a "NO" is returned.  If game is over, it will flagged all playing cards as faceup.
*/
- (BOOL)isGameOver {
#warning Need to implement a generic game over.
    return NO;
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
        self.lastFlipResult = [self.lastFlipResult stringByAppendingFormat:@"GAME TIME\nMATCH %D CARDS!!!", self.matchNumberOfCards];
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

// Game logic for N-Match
- (void)flipCardAtIndex:(NSUInteger)index {

    Card *card = [self cardAtIndex:index];
    
    self.lastFlipResult = [@"Re-Flipped" stringByAppendingFormat:@" %@",card.contents];
    
    if (!card.faceUp && !card.isUnplayable) {
        self.lastFlipResult = [@"Flipped" stringByAppendingFormat:@" %@",card.contents];
        
        // Another flip, update "score"
        self.score += [CardMatchingGame getFlipCost];
        
        // Get array of cards that are playable and faceup.
        NSMutableArray *otherCards = [self getPlayableFaceUpCards];
  
        // Are we building or at minimum cards required for matching?
        BOOL enoughCardsToMatch = ([otherCards count] + 1 == [self matchNumberOfCards]) ? YES : NO;
       
        // Check if cards make a match
        int matchScore = [card match:otherCards];
        
        if (matchScore) {
            if (enoughCardsToMatch)  {
                self.lastFlipResult = @"Matched:";
                
                for (Card *otherCard in otherCards) {
                    otherCard.unplayable = YES;
                    self.lastFlipResult = [self.lastFlipResult stringByAppendingFormat:@" %@", otherCard.contents];
                }
                
                self.lastFlipResult = [self.lastFlipResult stringByAppendingFormat:@" %@", card.contents];
                
                self.score += [CardMatchingGame getMatchBonus];
                card.unplayable = YES;
            }

            
        } else {
            // Game rules says these "otherCards" do not match.
            // Make "otherCards" face down.
            
            
            self.lastFlipResult = @"Miss-Match:";
            
            for (Card *otherCard in otherCards) {
                otherCard.faceUp = !otherCard.isFaceUp;
                self.lastFlipResult = [self.lastFlipResult stringByAppendingFormat:@" %@", otherCard.contents];
            }
            
            self.lastFlipResult = [self.lastFlipResult stringByAppendingFormat:@" %@", card.contents];
            
            self.score += [CardMatchingGame getMismatchPenalty];
        }        
    }
    
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
