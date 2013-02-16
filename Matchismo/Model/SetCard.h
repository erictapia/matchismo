//
//  SetCard.h
//  Matchismo
//
//  Created by Eric Tapia on 2/8/13.
//  Copyright (c) 2013 Eric Tapia. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card
    @property (nonatomic) NSUInteger color;     // 0 (Red),  1 (Green),   2 (Purple)
    @property (nonatomic) NSUInteger number;    // 0 (1),    1 (2),       2 (3)
    @property (nonatomic) NSUInteger shading;   // 0 (open), 1 (striped), 2 (solid)
    @property (nonatomic) NSUInteger symbol;    // 0 (▲),    1 (●),       2 (■)

    + (NSArray *)validNumbers;
    + (NSArray *)validShading;
    + (NSArray *)validColors;
    + (NSArray *)validSymbols;
    + (NSArray *)validStringSymbols;
@end
