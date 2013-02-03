//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Eric Tapia on 1/31/13.
//  Copyright (c) 2013 Eric Tapia. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
    @property (strong, nonatomic) NSMutableArray *cards;
    @property (nonatomic, readwrite) int score;
    @property (nonatomic) NSUInteger matchNumberOfCards;
    @property (nonatomic, readwrite) NSString *history;
@end

@implementation CardMatchingGame

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 2
#define MINIMUM_MATCH_CARDS 2

@synthesize history = _history;

- (NSString *)history {
    return _history ? _history : @"";;
}

- (void)setHistory:(NSString *)history {
    _history = history;
}

- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck matchNumberOfCards:(NSUInteger)matchNumberOfCards {
    self = [super init];
    
    if (self) {
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
        
        // Must match at least 2
        if ( matchNumberOfCards < 2) {
            self.matchNumberOfCards = MINIMUM_MATCH_CARDS;
        } else {
            self.matchNumberOfCards = matchNumberOfCards;
        }
        self.history = [self.history stringByAppendingFormat:@"GAME TIME\nMATCH %D CARDS!!!", matchNumberOfCards];
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

// Game logic for N-Match
- (void)flipCardAtIndex:(NSUInteger)index {
    NSUInteger matchingCards = 0;
    NSUInteger misMatchCards = 0;
    NSUInteger matchScore = 0;
    NSUInteger cumulativeMatchScore = 0;
    NSMutableArray *facingUpAndPlayable = [[NSMutableArray alloc] init];
    
    Card *card = [self cardAtIndex:index];
    
    self.history = @"";
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            matchingCards += 1; // Flipped card.
            self.history = [self.history stringByAppendingFormat:@"[ %@ ]", card.contents];
            
            // See if flipping this card up creates a match
            for(Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    self.history = [self.history stringByAppendingFormat:@" %@", otherCard.contents];
                    [facingUpAndPlayable addObject:otherCard];
                    matchScore = [card match:@[otherCard]];
                    if (matchScore > 0) {
                        matchingCards += 1;
                        cumulativeMatchScore += matchScore;
                    } else { // Non-Matchin cards
                        misMatchCards += 1;
                    }
                }
            }
            self.score -= FLIP_COST;
            
            if (matchingCards == self.matchNumberOfCards) {
                self.score += cumulativeMatchScore * MATCH_BONUS * self.matchNumberOfCards;
                
                card.unplayable = YES;
                
                for(Card *otherCard in facingUpAndPlayable) {
                    otherCard.unplayable = YES;
                }
                
                self.history = [self.history stringByAppendingFormat:@" \nPOW!!!! They match! \n%d Points.", cumulativeMatchScore * MATCH_BONUS * self.matchNumberOfCards];
                
            } else if ( misMatchCards > 0 ){ // remove
                self.score -= MISMATCH_PENALTY;
                for (Card *otherCard in facingUpAndPlayable) {
                    otherCard.faceUp = NO;
                }
                self.history = [self.history stringByAppendingFormat:@" \nBOO!!!! They do not match.\n-%d Points.", MISMATCH_PENALTY];
                
            }
        }
        card.faceUp = !card.isFaceUp;
    }
}

@end
