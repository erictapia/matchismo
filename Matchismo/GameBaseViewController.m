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

- (void)updateUIButton:(UIButton *)cardButton usingCard:(Card *)card {

}

- (NSAttributedString *)getUIAttributedContents:(Card *)card {
    return NULL;
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
    self.scoreLabel.text    = [self getUIScoreLabel:self.game.score];
    
    [self updateUIButtons];
    [self updateResultLabel];
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
