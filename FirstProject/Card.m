//
//  Card.m
//  FirstProject
//
//  Created by Apostol Apostolov on 1/14/14.
//
//

#import "Card.h"

@interface Card()

@end

@implementation Card

- (int) match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if([card.contents isEqualToString:self.contents]){
            score=1;
        }
    }
    
    
    return score;
}

@end
