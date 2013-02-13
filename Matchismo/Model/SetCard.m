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

// CLASS METHODS --------------------------------------------------------

// From Joan Carles Catalan
- (NSString *) contents
{

    NSArray *symbols = [SetCard validStringSymbols];
    
    NSString *symbolNumber = [@"" stringByPaddingToLength:self.number withString: symbols[self.symbol] startingAtIndex:0];
    
    return [NSString stringWithFormat:@"%@",symbolNumber];
}


// From Joan Carles Catalan
- (int)match:(NSArray *)otherCards {
    int score = 0;
    int otherCardsCount = [otherCards count];
    
    int colorCount      = self.color;
    int numberCount     = self.number;
    int shadingCount    = self.shading;
    int symbolCount     = self.symbol;
    
    if (otherCardsCount == 2) {
        for (SetCard *otherCard in otherCards) {
            colorCount      += otherCard.color;
            numberCount     += otherCard.number;
            shadingCount    += otherCard.shading;
            symbolCount     += otherCard.symbol;
        }
        
        // All 4 properties are a set, return 1 otherwise return 0
        score = (colorCount % 3 == 0) && (numberCount % 3 == 0) && (shadingCount % 3 == 0) && (symbolCount % 3 == 0) ? 1 : 0;
        
    }
    return  score;
}







// CLASS METHODS --------------------------------------------------------

+ (NSArray *)validColors {
    return @[@(1), @(2), @(3)];
}

+ (NSArray *)validNumbers {
    return @[@(1), @(2), @(3)];
}

+ (NSArray *)validShading {
    return @[@(1), @(2), @(3)];
}

+ (NSArray *)validSymbols {
    return @[@(1), @(2), @(3)];
}

+ (NSArray *)validStringSymbols {
    return @[@"?", @"▲",@"●",@"■"];
}

@end
