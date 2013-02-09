//
//  Tally.m
//  Matchismo
//
//  Created by Eric Tapia on 2/5/13.
//  Copyright (c) 2013 Eric Tapia. All rights reserved.
//

#import "Tally.h"

@interface Tally()
    @property (nonatomic) NSMutableDictionary *tally;
    @property (nonatomic, readwrite) NSInteger highestTallyCount;
@end

@implementation Tally

- (NSMutableDictionary *)tally {
    if(!_tally)
        _tally = [[NSMutableDictionary alloc] init];
    
    return _tally;
}

- (NSInteger)highestTallyCount {
    if(!_highestTallyCount) 
        _highestTallyCount = 0;
    
    return _highestTallyCount;
}

- (void)updateKey:(id)key byAddingValue:(int) value {
    NSNumber *currentTally = [self.tally objectForKey:key];

    if (currentTally) 
        [self.tally setObject:@([currentTally intValue] + value) forKey:key];
    else 
        [self.tally setObject:@(value) forKey:key];
    

    [self updateHighestTallyCount];
}

- (void)updateHighestTallyCount{
    
    NSInteger maxTally = 0;
    
    for (id key in self.tally) {
        if ( [[self.tally objectForKey:key] intValue] > maxTally)
            maxTally = [[self.tally objectForKey:key] intValue];
    }
    
    self.highestTallyCount = maxTally;
}


@end
