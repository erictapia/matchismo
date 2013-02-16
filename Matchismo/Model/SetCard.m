//
//  SetCard.m
//  Matchismo
//
//  Created by Eric Tapia on 2/8/13.
//  Copyright (c) 2013 Eric Tapia. All rights reserved.
//

#import "SetCard.h"
#import "Card.h"

@interface SetCard()

@end

@implementation SetCard

// From Joan Carles Catalan
- (NSString *) contents
{

    NSArray *symbols = [SetCard validStringSymbols];


    NSString *symbolNumber = [@"" stringByPaddingToLength:self.number +1 withString: symbols[self.symbol] startingAtIndex:0];
    
    return [NSString stringWithFormat:@"%@",symbolNumber];
}


#define SELF 1

- (int)match:(NSArray *)otherCards {
    
    
    int cardsCount = [otherCards count] + SELF;
    
    // Special Case: if card count = 2 then always a set
    if (cardsCount == 2) {
        return  1;
    }

    int colorSum    = self.color;
    int numberSum   = self.number;
    int shadingSum  = self.shading;
    int symbolSum   = self.symbol;
    
    for (SetCard *otherCard in otherCards) {
        colorSum    += otherCard.color;
        numberSum   += otherCard.number;
        shadingSum  += otherCard.shading;
        symbolSum   += otherCard.symbol;
    }

    return  (colorSum   % cardsCount == 0)  &&
            (numberSum  % cardsCount == 0)  &&
            (shadingSum % cardsCount == 0)  &&
            (symbolSum  % cardsCount == 0);
}

// CLASS METHODS --------------------------------------------------------

+ (NSArray *)validColors {
    return @[@(0), @(1), @(2)];
}

+ (NSArray *)validNumbers {
    return @[@(0), @(1), @(2)];
}

+ (NSArray *)validShading {
    return @[@(0), @(1), @(2)];
}

+ (NSArray *)validSymbols {
    return @[@(0), @(1), @(2)];
}

+ (NSArray *)validStringSymbols {
    return @[@"▲",@"●",@"■"];
}

@end
