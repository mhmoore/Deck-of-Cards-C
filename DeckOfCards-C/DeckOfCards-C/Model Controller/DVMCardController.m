//
//  DVMCardController.m
//  DeckOfCards-C
//
//  Created by Michael Moore on 8/20/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

#import "DVMCardController.h"
#import "DVMCard.h"

@implementation DVMCardController

//+ (DVMCardController *) shared {
//    static DVMCardController *shared = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        shared = [DVMCardController new];
//    });
//    return shared;
//}

+ (void)drawANewCard:(NSInteger)count completed:(void (^)(NSArray<DVMCard *> *cards, NSError *))completion {
    NSString *cardCount = [@(count) stringValue];
    
    NSURL *baseURL = [[NSURL alloc] initWithString:@"https://deckofcardsapi.com/api/deck/new/draw/"];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *countQueryItem = [NSURLQueryItem queryItemWithName:@"count" value:cardCount];
    urlComponents.queryItems = @[countQueryItem];
    NSURL *finalURL = urlComponents.URL;
    
    [[NSURLSession.sharedSession dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"There was an error fetching a card. %@: %@", error, error.localizedDescription);
            completion(nil, error); return;
        }
        
        if (!data) {
            NSLog(@"There was an error fetching data. %@: %@", error, error.localizedDescription);
            completion(nil, error); return;
        }
        
        NSDictionary *jsonDictionaries = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        NSArray *cardsArray = jsonDictionaries[@"cards"];
        
        NSMutableArray *cardsPlaceholder = [NSMutableArray array];
        
        for (jsonDictionaries in cardsArray) {
            DVMCard *card = [[DVMCard alloc] initWithDictionary:jsonDictionaries];
            [cardsPlaceholder addObject:card];
        }
        completion(cardsPlaceholder, nil);
    }]  resume];
}

+ (void)fetchCardImage:(DVMCard *)card completed:(void (^)(UIImage *))completion {
    NSURL *imageURL = [NSURL URLWithString: card.image];
    
    [[NSURLSession.sharedSession dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"There was an error fetching the image. %@, %@", error, error.localizedDescription);
            completion(nil); return;
        }
        
        if (!data) {
            NSLog(@"There was an error in the image data. %@, %@", error, error.localizedDescription);
            completion(nil); return;
        }
        
        UIImage *cardImage = [UIImage imageWithData:data];
        completion(cardImage);
    }] resume];
}

@end
