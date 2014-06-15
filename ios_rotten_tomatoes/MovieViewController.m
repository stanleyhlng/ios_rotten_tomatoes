//
//  MovieViewController.m
//  ios_rotten_tomatoes
//
//  Created by Stanley Ng on 6/9/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

#import "MovieViewController.h"
#import "UIImageView+AFNetworking.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

@interface MovieViewController ()

@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieSynopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *moviePosterImageView;

@end

@implementation MovieViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Movie Title
    NSString *title = [self.movie objectForKey:@"title"];
    title = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.title = title;
    self.movieTitleLabel.text = title;
    
    // Movie Synopsis
    self.movieSynopsisLabel.text = [self.movie objectForKey:@"synopsis"];
    
    // Movie Poster (low-res)
    [self.moviePosterImageView setAlpha:0.0f];
    [self.moviePosterImageView
     setImageWithURL:[NSURL URLWithString:self.movie[@"posters"][@"thumbnail"]]
     placeholderImage:[UIImage imageNamed:@"MovieImagePlaceholder"]
     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
         // Fade in image
         [UIView beginAnimations:@"fade in" context:nil];
         [UIView setAnimationDuration:1.0];
         [self.moviePosterImageView setAlpha:1.0f];
         [UIView commitAnimations];
         
         // Load hi-res
         [self.moviePosterImageView
          setImageWithURL:[NSURL URLWithString:self.movie[@"posters"][@"original"]]
          placeholderImage:self.moviePosterImageView.image
          ];
     }
     usingActivityIndicatorStyle: UIActivityIndicatorViewStyleWhite
     ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
