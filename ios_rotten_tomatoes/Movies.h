//
//  Movies.h
//  ios_rotten_tomatoes
//
//  Created by Stanley Ng on 6/15/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movies : NSObject

@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, strong) NSString *current;

+ (instancetype)instance;

- (NSString *)getCurrent;
- (NSString *)getCurrentUrl;
- (NSString *)getCurrentTitle;

@end
