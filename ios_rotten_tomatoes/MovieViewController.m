//
//  MovieViewController.m
//  ios_rotten_tomatoes
//
//  Created by Stanley Ng on 6/9/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

#import "MovieViewController.h"
#import "UIImageView+AFNetworking.h"

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
    
    // Movie Poster
    NSURL *url = [NSURL URLWithString:self.movie[@"posters"][@"detailed"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:@"MovieImagePlaceholder"];
    [self.moviePosterImageView setImageWithURLRequest:request
                                     placeholderImage:placeholderImage
                                              success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                  self.moviePosterImageView.image = image;
                                              }
                                              failure:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
