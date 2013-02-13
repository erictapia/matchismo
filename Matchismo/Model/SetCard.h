//
//  SetCard.h
//  Matchismo
//
//  Created by Eric Tapia on 2/8/13.
//  Copyright (c) 2013 Eric Tapia. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card
    @property (nonatomic) NSUInteger color;     // Red, Green, Purple
    @property (nonatomic) NSUInteger number;    // Range: 1-3
    @property (nonatomic) NSUInteger shading;   // 1 (solid), 2 (striped), 3 (open)
    @property (nonatomic) NSUInteger symbol;      // ▲, ●, ■

    + (NSArray *)validNumbers;
    + (NSArray *)validShading;
    + (NSArray *)validColors;
    + (NSArray *)validSymbols;
    + (NSArray *)validStringSymbols;
@end
