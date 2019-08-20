//
//  DVMCard.h
//  DeckOfCards-C
//
//  Created by Michael Moore on 8/20/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DVMCard : NSObject

@property (nonatomic, copy, readonly) NSString *suit;
@property (nonatomic, copy, readonly) NSString *image;

-(instancetype)initWithSuit:(NSString *)suit image:(NSString *)image;

@end

@interface DVMCard (JSONConvertable)
-(instancetype)initWithDictionary:(NSDictionary<NSArray *, id> *)jsonDictionary;

@end

NS_ASSUME_NONNULL_END
