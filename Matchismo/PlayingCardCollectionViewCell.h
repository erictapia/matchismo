//
//  PlayingCardCollectionViewCell.h
//  Matchismo
//
//  Created by Eric Tapia on 2/20/13.
//  Copyright (c) 2013 Eric Tapia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCardView.h"

@interface PlayingCardCollectionViewCell : UICollectionViewCell

    @property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@end
