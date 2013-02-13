//
//  GameBaseProtocol.h
//  Matchismo
//
//  Created by Eric Tapia on 2/11/13.
//  Copyright (c) 2013 Eric Tapia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@protocol GameBase <NSObject>

    - (NSUInteger)cardsToMatch;

    - (Deck *)getDeck;

    - (NSString *)getUIFlipsLabel:(NSInteger)flips;
    - (NSString *)getUIResultLabel:(NSString *)result;
    - (NSString *)getUIScoreLabel:(NSInteger)score;

    - (void)updateUIButton:(UIButton *)cardButton usingCard:(Card *)card;

@end
