//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Eric Tapia on 2/9/13.
//  Copyright (c) 2013 Eric Tapia. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id)init {
    self = [super init];
    
    if (self) {

        // Build deck with all combinations
        for (NSNumber *color in [SetCard validColors]) {
            for(NSNumber *number in [SetCard validNumbers]) {
                for (NSNumber *shading in [SetCard validShading]) {
                    for (NSNumber *symbol in [SetCard validSymbols]) { // TODO - IMPLEMENT WITHOUT MAGIC NUMBERS
                        SetCard *card = [[SetCard alloc] init];
                        
                        card.color      = [color unsignedIntegerValue];
                        card.number     = [number unsignedIntegerValue];
                        card.shading    = [number unsignedIntegerValue];
                        card.symbol     = [symbol unsignedIntegerValue];
                        
                        [self addCard:card atTop:NO];
                    }
                }
            }
        }
        
    }
    
    return self;
}



@end
