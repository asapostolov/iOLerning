//
//  Deck.h
//  FirstProject
//
//  Created by Apostol Apostolov on 1/14/14.
//
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void) addCard:(Card *)card atTop:(BOOL) atTop;
- (void) addCard:(Card *)card;


-(Card *)drawRandomCard;

@end
