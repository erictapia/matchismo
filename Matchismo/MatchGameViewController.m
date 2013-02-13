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

#define CARDS_TO_MATCH 2

- (NSUInteger)cardsToMatch {
    return CARDS_TO_MATCH;    
}

- (Deck *)getDeck {
    return [[PlayingCardDeck alloc] init];    
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
    [super updateUIButton:cardButton usingCard:card];
}

@end
