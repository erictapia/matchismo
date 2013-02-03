//
//  Deck.h
//  Matchismo
//
//  Created by Eric Tapia on 1/25/13.
//  Copyright (c) 2013 Eric Tapia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
    - (void)addCard:(Card *)card atTop:(BOOL)atTop;
    - (Card *)drawRandomCard;
@end
