//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Eric Tapia on 2/8/13.
//  Copyright (c) 2013 Eric Tapia. All rights reserved.
//


#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "Card.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController

#define CARDS_TO_MATCH  3

#define ALPHA_NONE      0.0
#define ALPHA_QUARTER   0.25
#define ALPHA_HALF      0.50
#define ALPHA_WHOLE     1.00
#define STROKE_WIDTH    -5



- (NSUInteger)cardsToMatch {
    return CARDS_TO_MATCH;
}

- (Deck *)getDeck {
    return [[SetCardDeck alloc] init];
}

- (NSString *)getUIFlipsLabel:(NSInteger)flips {
    return [NSString stringWithFormat:@"Flips: %d", flips];
}

- (NSString *)getUIScoreLabel:(NSInteger)score {
    return [NSString stringWithFormat:@"Score: %d", score];
}

- (NSString *)getUIResultLabel:(NSString *)result {
    return result;
}


- (void)updateUIButton:(UIButton *)cardButton usingCard:(Card *)card {    
    [cardButton setAttributedTitle:[self cardAttributedContents:card]  forState:UIControlStateNormal];
    [cardButton setAttributedTitle:[self cardAttributedContents:card] forState:UIControlStateSelected];
    [cardButton setAttributedTitle:[self cardAttributedContents:card] forState:UIControlStateSelected|UIControlStateDisabled];
    
    cardButton.selected = card.isFaceUp;
    cardButton.enabled  = !card.isUnplayable;
        
    if (cardButton.enabled && cardButton.selected) {
        cardButton.alpha    = ALPHA_HALF;
    } else if (!cardButton.enabled){
        cardButton.alpha    = ALPHA_NONE;
    } else {
        cardButton.alpha    = ALPHA_WHOLE;
    }
}

- (NSAttributedString *)cardAttributedContents:(Card *)card {

    
    NSInteger colorIndex    = ((SetCard *)card).color;
    NSInteger shadingIndex  = ((SetCard *) card).shading;
    
    CGFloat shading = [@[@ALPHA_NONE, @ALPHA_QUARTER, @ALPHA_WHOLE][shadingIndex] floatValue];
    
    UIColor *strokeColor = @[[UIColor redColor], [UIColor greenColor], [UIColor purpleColor]][colorIndex];
    UIColor *foregroundColor = [strokeColor colorWithAlphaComponent:shading];
    
    return [[NSAttributedString alloc] initWithString:card.contents
                                           attributes:@{NSForegroundColorAttributeName : foregroundColor,
                                                            NSStrokeColorAttributeName : strokeColor,
                                                            NSStrokeWidthAttributeName : @STROKE_WIDTH}];
    
}

@end
