//
//  Movies.m
//  ios_rotten_tomatoes
//
//  Created by Stanley Ng on 6/15/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

#import "Movies.h"

@implementation Movies

+ (instancetype)instance
{
    static Movies *movies = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        movies = [Movies new];
        
        NSDictionary *data = @{
                               @"box_office":@{
                                       @"url":@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=g9au4hv6khv6wzvzgt55gpqs",
                                       @"title": @"Box Office"
                                       },
                               @"top_rentals":@{
                                       @"url":@"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs",
                                       @"title": @"Top Rentals"
                                       }
                               };
        movies.data = data;
        movies.current = @"box_office";
        
    });
    
    return movies;
}

- (NSString *)getCurrent
{
    return self.current;
}

- (NSString *)getCurrentUrl
{
    NSString *url = nil;
    NSDictionary *data = [self.data objectForKey:self.current];
    if (data) {
        url = [data objectForKey:@"url"];
    }
    return url;
}

- (NSString *)getCurrentTitle
{
    NSString *url = nil;
    NSDictionary *data = [self.data objectForKey:self.current];
    if (data) {
        url = [data objectForKey:@"title"];
    }
    return url;
}

@end
