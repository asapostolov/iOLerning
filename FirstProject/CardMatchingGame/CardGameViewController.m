//
//  CardGameViewController.m
//  CardMatchingGame
//
//  Created by Apostol Apostolov on 1/13/14.
//
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (nonatomic) Deck *currentDeck;
@property (nonatomic,strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
    }
    return  _game;
}

-(Deck *)currentDeck
{
    if(!_currentDeck){
        _currentDeck = [self createDeck];
    }
    return _currentDeck;
}

-(Deck *) createDeck
{
    return [[PlayingCardDeck alloc] init];
}


- (IBAction)touchCardButton:(UIButton *)sender
{
    int cardIndex = [self.cardButtons indexOfObject:sender];
    
    [self.game chooseCardAtIndex:cardIndex];
    
    [self updateUI];
    
}

-(void) updateUI
{
    for (UIButton *cardButon in self.cardButtons) {
        int cardIndex = [self.cardButtons indexOfObject:cardButon];
        
        Card *card = [self.game cardAtIndex:cardIndex];
        
        [cardButon setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButon setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButon.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score %d",self.game.score];
}

-(NSString *) titleForCard:(Card *) card
{
    return card.isChosen?card.contents:@"";
}

-(UIImage *) backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed:card.isChosen?@"cardfront":@"cardback"];
}

@end
