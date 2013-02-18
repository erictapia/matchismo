//
//  MatchGameViewController.m
//  Matchismo
//
//  Created by Eric Tapia on 2/12/13.
//  Copyright (c) 2013 Eric Tapia. All rights reserved.
//

#import "MatchGameViewController.h"
#import "PlayingCardDeck.h"
#import "Card.h"

@interface MatchGameViewController ()

@end

@implementation MatchGameViewController

#define CARDS_TO_MATCH              2
#define ALPHA_FOR_PLAYABLE_CARD     1.0
#define ALPHA_FOR_UNPLAYABLE_CARD   0.3
#define ANIMATION_DURATION          0.5

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

- (void)updateUIButton:(UIButton *)cardButton usingCard:(Card *)card {
    [cardButton setTitle:card.contents forState:UIControlStateSelected];
    [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
    
    
    if (card.isFaceUp)
        [cardButton setImage:nil forState:UIControlStateNormal];
    else
        [cardButton setImage:[UIImage imageNamed:@"cardback.jpg"] forState:UIControlStateNormal];
    
    if (cardButton.selected != card.isFaceUp) {
        
        [UIView transitionWithView:cardButton
                          duration:ANIMATION_DURATION
                           options:UIViewAnimationOptionTransitionFlipFromRight
                        animations:^{}
                        completion:NULL];
    }
    
    cardButton.selected = card.isFaceUp;
    cardButton.enabled  = !card.isUnplayable;
    cardButton.alpha    = card.isUnplayable ? ALPHA_FOR_UNPLAYABLE_CARD : ALPHA_FOR_PLAYABLE_CARD;
}

- (NSAttributedString *)getUIAttributedContents:(Card *)card {
    return [[NSAttributedString alloc] initWithString:card.contents];
}

@end
