//
//  PlayingCard.m
//  FirstProject
//
//  Created by Apostol Apostolov on 1/14/14.
//
//

#import "PlayingCard.h"


@implementation PlayingCard

@synthesize suit = _suit;

+(NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

-(int) match:(NSArray *)otherCards
{
    int score = 0;
    if([otherCards count]==1)
    {
        PlayingCard *otherCard = [otherCards firstObject];
        
        if([self.suit isEqualToString:otherCard.suit]){
            score = 1;
        }else if (self.rank == otherCard.rank){
            score = 4;
        }
    }
    return score;
}

-(void) setSuit:(NSString *) suit
{
    if([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

-(NSString *) suit
{
    return _suit ? _suit : @"?";
}

+(NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", @"K",@"J",@"Q"];
}

+(NSUInteger) maxRank { return [[self rankStrings] count] - 1; }

-(NSString *) contents{
    
    return [PlayingCard.rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (void) setRank:(NSUInteger) rank
{
    if(rank<=[PlayingCard maxRank]){
        _rank = rank;
    }
}



@end