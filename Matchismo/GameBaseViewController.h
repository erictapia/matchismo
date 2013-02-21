//
//  GameBaseViewController.h
//  Matchismo
//
//  Created by Eric Tapia on 2/11/13.
//  Copyright (c) 2013 Eric Tapia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"

@interface GameBaseViewController : UIViewController

// ABSTRACT PROPERTIES
    @property (nonatomic) NSUInteger startingCardCount;

// ABSTRACT METHODS
    - (NSUInteger)cardsToMatch;
    - (Deck *)getDeck;
    - (NSString *)getUIFlipsLabel:(NSInteger)flips;
    - (NSString *)getUIScoreLabel:(NSInteger)score;
    - (NSAttributedString *)getUIAttributedContents:(Card *)card;

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animate:(BOOL)animate;


@end
