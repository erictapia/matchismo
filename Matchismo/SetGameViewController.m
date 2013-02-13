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

#define CARDS_TO_MATCH 3

- (NSUInteger)cardsToMatch {
    return CARDS_TO_MATCH;
}

- (Deck *)getDeck {
    return [[SetCardDeck alloc] init];
}

- (NSString *)getUIFlipsLabel:(NSInteger)flips {
    return [super getUIFlipsLabel:flips];
}

- (NSString *)getUIResultLabel:(NSString *)result{
    return [super getUIResultLabel:result];
}

- (NSString *)getUIScoreLabel:(NSInteger)score {
    return [super getUIScoreLabel:score];
}


- (void)updateUIButton:(UIButton *)cardButton usingCard:(Card *)card {
        
    [cardButton setAttributedTitle:[self cardAttributedContents:card forFaceUp:NO] forState:UIControlStateNormal];
    [cardButton setAttributedTitle:[self cardAttributedContents:card forFaceUp:YES] forState:UIControlStateSelected];
    [cardButton setAttributedTitle:[self cardAttributedContents:card forFaceUp:YES] forState:UIControlStateSelected|UIControlStateDisabled];
        
    cardButton.selected = card.isFaceUp;
    cardButton.enabled  = !card.isUnplayable;
        
    if (cardButton.enabled && cardButton.selected) {
        cardButton.alpha    = 0.6;
    } else if (!cardButton.enabled){
        cardButton.alpha    = 0;
    } else {
        cardButton.alpha    = 1.0;
    }
}


// From Joan Carles Catalan
- (NSAttributedString *)cardAttributedContents:(Card *)card forFaceUp:(BOOL)isFaceUp
{
    NSArray *colorPallette = @[[UIColor redColor],[UIColor greenColor],[UIColor purpleColor]];
    NSArray *alphaPallette = @[@0,@0.2,@1];
    
    UIColor *cardOutlineColor = colorPallette[((SetCard *)card).color-1]; // 0 base index
    UIColor *cardColor = [cardOutlineColor colorWithAlphaComponent:(CGFloat)[alphaPallette[((SetCard *)card).shading-1] floatValue]];
    
    NSDictionary *cardAttributes = @{NSForegroundColorAttributeName : cardColor, NSStrokeColorAttributeName : cardOutlineColor, NSStrokeWidthAttributeName: @-5};
    
    NSString *textToDisplay = card.contents;
    NSAttributedString *cardContents = [[NSAttributedString alloc] initWithString:textToDisplay attributes:cardAttributes];
    
    return cardContents;
}

@end
