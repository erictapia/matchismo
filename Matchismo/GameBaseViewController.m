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

@interface GameBaseViewController ()

    @property (nonatomic) int flipCount;
    @property (strong, nonatomic) CardMatchingGame *game;
    @property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
    @property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
    @property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
    @property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation GameBaseViewController


#define CARDS_TO_MATCH 2



/*
    ABSTRACT METHODS, must be implemented by any subclass.============================================
*/

- (NSUInteger)cardsToMatch {
    return NULL;
}

- (Deck *)getDeck {
    return NULL;
}

- (NSString *)getUIFlipsLabel:(NSInteger)flips {
    return NULL;
}

- (NSString *)getUIScoreLabel:(NSInteger)score {
    return NULL;
}

- (NSString *)getUIResultLabel:(NSString *)result {
    return NULL;
}

- (void)updateUIButton:(UIButton *)cardButton usingCard:(Card *)card {

}


// Private core methods =========================================================================

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self updateUI];
}

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc]
                 initWithCardCount:[self.cardButtons count]
                 usingDeck:[self getDeck]
                 matchNumberOfCards:[self cardsToMatch]];
    }
    return _game;
}

- (void) setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [self getUIFlipsLabel:self.flipCount];
}

- (void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI {
    self.scoreLabel.text    = [self getUIScoreLabel: self.game.score];
    self.resultLabel.text   = [self getUIResultLabel: self.game.lastFlipResult];
    
    [self updateUIButtons];
}

- (void)updateUIButtons {
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];

#warning CHANGE THIS TO USE ATTRIBUTED STRING AND WITHOUT PASSING OBJECT
        [self updateUIButton:cardButton usingCard:card];
    }
}

- (IBAction)deal:(UIButton *)sender {
    self.game = nil;
    self.flipCount = 0;
    self.flipsLabel.text = @"Flips: 0";
    [self updateUI];
}

- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    
    if (!sender.selected)
        self.flipCount++;
    
    [self updateUI];
}
@end
