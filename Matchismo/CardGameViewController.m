//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Eric Tapia on 1/25/13.
//  Copyright (c) 2013 Eric Tapia. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "Card.h"

@interface CardGameViewController ()
    @property (nonatomic) int flipCount;
    @property (strong, nonatomic) CardMatchingGame *game;
    @property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
    @property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
    @property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
    @property (weak, nonatomic) IBOutlet UISlider *difficultySlider;
    @property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@end

@implementation CardGameViewController


- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[PlayingCardDeck alloc] init]
                                         matchNumberOfCards:_difficultySlider.value];
    }
    return _game;
}

- (void) setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI {
    //NSString *gameover;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
    self.resultLabel.text = self.game.history;
    
    if ([self.game isGameOver]) {
        self.resultLabel.text = [self.resultLabel.text stringByAppendingString:@"\nGame Over"];
    }
    
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];

        if (card.isFaceUp) {
            [cardButton setImage:nil forState:UIControlStateNormal];
        } else {
            [cardButton setImage:[UIImage imageNamed:@"cardback.jpg"] forState:UIControlStateNormal];
        }
        
        // from https://github.com/tsunglintsai/standford-cs193p-01-card-game (149-154)
        if (cardButton.selected != card.isFaceUp) {
            [UIView beginAnimations:@"flipbutton" context:NULL];
            [UIView setAnimationDuration:0.4];
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:cardButton cache:YES];
            [UIView commitAnimations];
        }
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
}

- (IBAction)flipCard:(UIButton *)sender {
    if (self.difficultySlider.isEnabled) {
        self.difficultySlider.enabled = !self.difficultySlider.enabled;
    }
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    if (!sender.selected)
        self.flipCount++;
    [self updateUI];
}

- (IBAction)deal:(UIButton *)sender {
    self.game = nil;
    self.flipCount = 0;
    self.flipsLabel.text = @"Flips: 0";
    self.difficultySlider.enabled = YES;
    [self updateUI];
}

- (IBAction)difficultySliderChange:(UISlider *)sender {
    [self.difficultySlider setValue:roundf(sender.value) animated:YES];
    self.game = nil;
    [self updateUI];
}


@end
