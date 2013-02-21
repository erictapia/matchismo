//
//  GameBaseViewController.m
//  Matchismo
//
//  Created by Eric Tapia on 2/11/13.
//  Copyright (c) 2013 Eric Tapia. All rights reserved.
//

#import "GameBaseViewController.h"
#import "Card.h"
#import "Deck.h"
#import "CardMatchingGame.h"

@interface GameBaseViewController () <UICollectionViewDataSource>

    @property (nonatomic) int flipCount;
    @property (strong, nonatomic) CardMatchingGame *game;
//    @property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
    @property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
    @property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
    @property (weak, nonatomic) IBOutlet UILabel *resultLabel;

    @property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;



@end

@implementation GameBaseViewController 


#define CARDS_TO_MATCH 2



/*
    ABSTRACT METHODS, must be implemented by any subclass.============================================
*/

- (NSUInteger)cardsToMatch {
    return nil;
}

- (Deck *)getDeck {
    return nil;
}

- (NSString *)getUIFlipsLabel:(NSInteger)flips {
    return nil;
}

- (NSString *)getUIScoreLabel:(NSInteger)score {
    return nil;
}

- (void)updateUIButton:(UIButton *)cardButton usingCard:(Card *)card {

}

- (NSAttributedString *)getUIAttributedContents:(Card *)card {
    return nil;
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animate:(BOOL)animate {
    
}


// Private core methods =========================================================================

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.startingCardCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PlayingCard" forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card animate:NO];
    
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self updateUI];
}

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc]
                 initWithCardCount:[self startingCardCount]
                         usingDeck:[self getDeck]
                matchNumberOfCards:[self cardsToMatch]];
    }
    return _game;
}

- (void) setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [self getUIFlipsLabel:self.flipCount];
}

- (void)updateUI {
    self.scoreLabel.text    = [self getUIScoreLabel:self.game.score];
    [self updateResultLabel];
 
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells]) {
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card animate:NO];
    }
}

- (void)updateResultLabel {
    
    
    if ([self.game.lastResult count] > 0) {
        
        NSMutableAttributedString *resultText = [[NSMutableAttributedString alloc] init];
        
        NSAttributedString *separator = [[NSAttributedString alloc] initWithString:@"\n"];
        NSAttributedString *points = [[NSAttributedString alloc] initWithString:@" Points"];
        NSAttributedString *whiteSpace = [[NSAttributedString alloc] initWithString:@" "];
        
        [resultText appendAttributedString:[[NSAttributedString alloc] initWithString:[self.game.lastResult objectForKey:@"RESULT"]]];
        [resultText appendAttributedString:separator];
        
        NSArray *cards = [self.game.lastResult objectForKey:@"CARD"];
        
        for (Card *card in cards) {            
            [resultText appendAttributedString:[self getUIAttributedContents:card]];
            [resultText appendAttributedString:whiteSpace];
        }
        
        [resultText appendAttributedString:separator];
        [resultText appendAttributedString:[[NSAttributedString alloc] initWithString:[(NSNumber *)[self.game.lastResult objectForKey:@"SCORE"] stringValue]]];
        [resultText appendAttributedString:points];
        
        self.resultLabel.attributedText = resultText;
    } else {
        self.resultLabel.text = @"Game Time";
    }
}

- (IBAction)deal:(UIButton *)sender {
    self.game = nil;
    self.flipCount = 0;
    self.flipsLabel.text = @"Flips: 0";
    [self updateUI];
}

- (IBAction)flipCard:(UITapGestureRecognizer *)gesture {
    
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
        
    if (indexPath ) {
        
        Card *card = [self.game cardAtIndex:indexPath.item];
        if (!card.isUnplayable) {
            [self.game flipCardAtIndex:indexPath.item];
            if (card.faceUp) {
                self.flipCount++;
            }
            
            [self updateUI];
            
            UICollectionViewCell *cell = [self.cardCollectionView cellForItemAtIndexPath:indexPath];
            [self updateCell:cell usingCard:card animate:YES];
        }
        
    }

}



@end
