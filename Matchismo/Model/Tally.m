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
    @property (nonatomic, readwrite) NSInteger maxKeyCount;
@end

@implementation Tally

- (NSMutableDictionary *)tally {
    if(!_tally) {
        _tally = [[NSMutableDictionary alloc] init];
    }
    
    return _tally;
}

- (NSInteger)maxKeyCount {
    if(!_maxKeyCount) {
        _maxKeyCount = 0;
    }
    
    return _maxKeyCount;
}

- (void)updateKeys:(id)key withIncrementValue:(int) value {
    NSNumber *currentValue = [self.tally objectForKey:key];

    if (currentValue) {
        NSNumber *newValue = [NSNumber numberWithInt:[currentValue intValue] + value];
        [self.tally setObject:newValue forKey:key];
        
        if ([newValue integerValue] > self.maxKeyCount) {
            self.maxKeyCount = [newValue integerValue];
        }
    } else {
        [self.tally setObject:[NSNumber numberWithInt:value] forKey:key];
    }

    [self checkMaxKeyCount];
}

- (void)checkMaxKeyCount{
    
    NSInteger maxValue = 0;
    
    for (id key in self.tally) {
        NSInteger value = [[self.tally objectForKey:key] intValue];
        if ( value > maxValue) {
            maxValue = value;
        }
    }
    
    self.maxKeyCount = maxValue;
}


@end
