//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Eric Tapia on 1/31/13.
//  Copyright (c) 2013 Eric Tapia. All rights reserved.
//

#import "CardMatchingGame.h"
#import "PlayingCard.h"
#import "Tally.h"

@interface CardMatchingGame()

// A property containing an array of game "cards"
    @property (strong, nonatomic) NSMutableArray *cards;

// A property containing the current game "score".
    @property (nonatomic, readwrite) int score;

// A property containing the "matchNumberOfCards" required for a match.
    @property (nonatomic) NSUInteger matchNumberOfCards;

// A property containing the "history" of the last flipped card result.
    @property (nonatomic, readwrite) NSString *history;

// Tally maintains game counts of all ranks and suits
    @property (nonatomic) Tally *tally;
@end

@implementation CardMatchingGame

// Score values
#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 2

#define MINIMUM_MATCH_CARDS 2

- (Tally *)tally {
    
    if (!_tally)
        _tally = [[Tally alloc] init];
    
    return _tally;
}

- (NSString *)history {
    return _history ? _history : @"";;
}

- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

/*
    This method checks the state of the game.  When the game is over, a "YES" is returned otherwise
    a "NO" is returned.  If game is over, it will flagged all playing cards as faceup.
*/
- (BOOL)isGameOver {
    BOOL gameOver = YES;

    if (self.tally.maxKeyCount >= self.matchNumberOfCards) {
        gameOver = NO;
    }

    if(gameOver) {
        for (Card *card in self.cards) {
            card.faceUp = YES;
        }
    }
    return gameOver;
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
                
                // Update rank and suit current tally by incrementing by 1. 
                NSNumber *rank = [NSNumber numberWithInt:((PlayingCard *)card).rank];
                [self.tally updateKeys:rank withIncrementValue:1];
                [self.tally updateKeys:[(PlayingCard *)card suit] withIncrementValue:1];
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
    
    // count of matching cards in its current state.
    NSUInteger matchingCards = 0;
    // count of miss match cards in its current state.
    NSUInteger misMatchCards = 0;
    NSUInteger matchScore = 0;
    NSUInteger cumulativeMatchScore = 0;
    NSMutableArray *facingUpAndPlayable = [[NSMutableArray alloc] init];
    
    Card *card = [self cardAtIndex:index];
    
    self.history = @"";
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            matchingCards += 1; // Flipped card, assume matching and base for all other matching cards.
            self.history = [self.history stringByAppendingFormat:@"[ %@ ]", card.contents];
            
            // Check if all other cards that are faceup and playable match.
            for(Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    self.history = [self.history stringByAppendingFormat:@" %@", otherCard.contents];
                    [facingUpAndPlayable addObject:otherCard];
                    matchScore = [card match:@[otherCard]];
                    
                    if (matchScore > 0) {
                        // Increment matching cards and keep cumulative match score
                        matchingCards += 1;
                        cumulativeMatchScore += matchScore;
                    } else {
                        // Increment Non-Matchin cards
                        misMatchCards += 1;
                    }
                }
            }
            
            self.score -= FLIP_COST;
            
            if (matchingCards == self.matchNumberOfCards) {
                self.score += cumulativeMatchScore * MATCH_BONUS * self.matchNumberOfCards;
                
                card.unplayable = YES;
                
                // For card, update tally by incrementing by -1. 
                [self.tally updateKeys:[NSNumber numberWithInt:[(PlayingCard *)card rank]] withIncrementValue:-1];
                [self.tally updateKeys:[(PlayingCard *)card suit] withIncrementValue:-1];
                
                for(Card *otherCard in facingUpAndPlayable) {
                    otherCard.unplayable = YES;

                    // For all other matching cards, update tally by incrementing by -1. 
                    [self.tally updateKeys:[NSNumber numberWithInt:[(PlayingCard *)otherCard rank]] withIncrementValue:-1];
                    [self.tally updateKeys:[(PlayingCard *)otherCard suit] withIncrementValue:-1];
                    
                }
                
                self.history = [self.history stringByAppendingFormat:@" \nPOW!!!! They match! \n%d Points.", cumulativeMatchScore * MATCH_BONUS * self.matchNumberOfCards];
                
            } else if ( misMatchCards > 0 ){
                // Miss match, set them as face down and deduct penalty for miss match.
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
