//
//  DVMCardController.h
//  DeckOfCards-C
//
//  Created by Michael Moore on 8/20/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class DVMCard;


@interface DVMCardController : NSObject

+(void)drawANewCard:(NSInteger)count completed:(void(^) (NSArray<DVMCard *> *cards, NSError *error))completion;
+(void)fetchCardImage:(DVMCard *)card completed:(void (^) (UIImage *image))completion;

// +(DVMCardController *)shared;

@end
