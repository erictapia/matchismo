//
//  Tally.h
//  Matchismo
//
//  Created by Eric Tapia on 2/5/13.
//  Copyright (c) 2013 Eric Tapia. All rights reserved.
//


/*
 Description: Tally is an object that maintains a count for each supplied key.  Key/tally
 is maintained in a NSMutableDictionary.
 */

#import <Foundation/Foundation.h>

@interface Tally : NSObject

// "maxKeycount" is a property for getting the max count of any key.
    @property (nonatomic, readonly) NSInteger maxKeyCount;

// Method to add "value" to the "key" current value. 
    - (void)updateKeys:(id)key withIncrementValue:(int) value;
@end
