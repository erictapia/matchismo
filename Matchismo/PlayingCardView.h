//
//  PlayingCardView.h
//  Matchismo
//
//  Created by Eric Tapia on 2/18/13.
//  Copyright (c) 2013 Eric Tapia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

    @property (nonatomic) NSUInteger rank;
    @property (strong, nonatomic) NSString *suit;

    @property (nonatomic) BOOL faceup;

@end
