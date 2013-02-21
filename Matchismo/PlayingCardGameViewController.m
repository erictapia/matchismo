//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Eric Tapia on 2/20/13.
//  Copyright (c) 2013 Eric Tapia. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "PlayingCardCollectionViewCell.h"

@implementation PlayingCardGameViewController

#define CARDS_TO_MATCH              2

// ABSTRACT METHODS
- (NSUInteger)cardsToMatch {
    return CARDS_TO_MATCH;    
}

- (Deck *)getDeck {
    return [[PlayingCardDeck alloc] init];
}

- (NSString *)getUIFlipsLabel:(NSInteger)flips {
    return [NSString stringWithFormat:@"Flips: %d", flips];    
}

- (NSString *)getUIScoreLabel:(NSInteger)score {
    return [NSString stringWithFormat:@"Score: %d", score];    
}

- (NSAttributedString *)getUIAttributedContents:(Card *)card {
    return [[NSAttributedString alloc] initWithString:card.contents];
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animate:(BOOL)animate {
    if ([cell isKindOfClass:[PlayingCardCollectionViewCell class]]) {
        PlayingCardView *playingCardView = ((PlayingCardCollectionViewCell *)cell).playingCardView;
        if ([card isKindOfClass:[PlayingCard class]]) {
            PlayingCard *playingCard = (PlayingCard *)card;
            playingCardView.rank = playingCard.rank;
            playingCardView.suit = playingCard.suit;
            playingCardView.faceup = playingCard.isFaceUp;
            playingCardView.alpha = playingCard.isUnplayable ? 0.3: 1.0;
            
            if (animate) {
                [UIView transitionWithView:playingCardView
                                  duration:0.5
                                   options:UIViewAnimationOptionTransitionFlipFromLeft
                                animations:^ {
                                    
                                }
                                completion:NULL];
            }
        }
        
    }
}

- (NSUInteger)startingCardCount {
    return 20;
}

@end
