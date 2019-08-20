//
//  DVMCard.m
//  DeckOfCards-C
//
//  Created by Michael Moore on 8/20/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

#import "DVMCard.h"

static NSString *const suitKey = @"suit";
static NSString *const imageKey = @"image";
static NSString *const cardKey = @"cards";

@implementation DVMCard

-(instancetype)initWithSuit:(NSString *)suit image:(NSString *)image {
    self = [super init];
    
    if (self) {
        _suit = suit;
        _image = image;
    }
    return self;
}
@end

@implementation DVMCard (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)jsonDictionary {
    NSDictionary *cardsArray = jsonDictionary[cardKey];
    NSString *suit = cardsArray[suitKey];
    NSString *image = cardsArray[imageKey];
    
    return [self initWithSuit:suit image:image];
}
@end
