//
//  CardMatchingGame.h
//  FirstProject
//
//  Created by Apostol Apostolov on 1/14/14.
//
//

#import <Foundation/Foundation.h>
#import "Deck.h"


@interface CardMatchingGame : NSObject

//designated initializer
-(instancetype) initWithCardCount:(NSUInteger) count usingDeck:(Deck *) deck;

-(void) chooseCardAtIndex:(NSUInteger) index;
-(Card *) cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;

@end
