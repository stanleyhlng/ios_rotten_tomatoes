//
//  MovieTableViewCell.h
//  ios_rotten_tomatoes
//
//  Created by Stanley Ng on 6/9/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieSynopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *moviePosterImageView;

@end
