//
//  PlayingCard.h
//  FirstProject
//
//  Created by Apostol Apostolov on 1/14/14.
//
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+(NSArray *) validSuits;
+(NSUInteger) maxRank;
@end
