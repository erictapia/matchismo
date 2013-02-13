//
//  GameBaseViewController.m
//  Matchismo
//
//  Created by Eric Tapia on 2/11/13.
//  Copyright (c) 2013 Eric Tapia. All rights reserved.
//

#import "GameBaseViewController.h"
#import "Deck.h"
#import "CardMatchingGame.h"
#import "Card.h"

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
    GameBase protocol, must be implemented by any subclass.============================================
*/

- (NSUInteger)cardsToMatch {
    return CARDS_TO_MATCH;
}

- (Deck *)getDeck {
    return [[Deck alloc] init];
}

- (NSString *)getUIFlipsLabel:(NSInteger)flips {
    return [NSString stringWithFormat:@"Flips: %d", flips];
}

- (NSString *)getUIScoreLabel:(NSInteger)score {
    return [NSString stringWithFormat:@"Score: %d", score];
}

- (NSString *)getUIResultLabel:(NSString *)result {
    return result;
}


// TODO: CHANGE THIS TO USE ATTRIBUTED STRING AND WITHOUT PASSING THE CARD
// SEE LECTURE 6 TO DO ANIMATION IN A ONE LINER.
- (void)updateUIButton:(UIButton *)cardButton usingCard:(Card *)card {
    [cardButton setTitle:card.contents forState:UIControlStateSelected];
    [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
    
    
    if (card.isFaceUp)
        [cardButton setImage:nil forState:UIControlStateNormal];
    else
        [cardButton setImage:[UIImage imageNamed:@"cardback.jpg"] forState:UIControlStateNormal];
    
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


// Private GameBase core methods =========================================================================

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
