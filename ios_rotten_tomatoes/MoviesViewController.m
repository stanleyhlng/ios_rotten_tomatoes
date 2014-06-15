//
//  MoviesViewController.m
//  ios_rotten_tomatoes
//
//  Created by Stanley Ng on 6/8/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieViewController.h"
#import "MovieTableViewCell.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "GSProgressHUD.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "AVHexColor.h"
#import "Movies.h"

@interface MoviesViewController ()

@property (weak, nonatomic) IBOutlet UITableView *moviesTableView;
@property (weak, nonatomic) IBOutlet UIView *errorView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSArray *movies;

@end

@implementation MoviesViewController

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
    
    NSLog(@"movies_vc: viewDidLoad");
    NSLog(@"url: %@", [[Movies instance] getCurrentUrl]);

    // Configure title
    self.title = [[Movies instance] getCurrentTitle];

    // Configure table view
    self.moviesTableView.delegate = self;
    self.moviesTableView.dataSource = self;
    
    [self.moviesTableView
     registerNib:[
                  UINib nibWithNibName:@"MovieTableViewCell"
                  bundle:nil
                  ]
     forCellReuseIdentifier:@"MovieTableViewCell"
     ];
    self.moviesTableView.rowHeight = 120;
    
    // Configure pull-to-refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.moviesTableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self
                       action:@selector(refreshTable)
             forControlEvents:UIControlEventValueChanged];

    // Fetch movies data
    [self fetchMovies];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshTable {
    [self.refreshControl endRefreshing];
    [self fetchMovies];
}

- (NSArray *)fetchMovies
{
    NSLog(@"fetchMovies");
    
    NSString *string = [[Movies instance] getCurrentUrl];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [GSProgressHUD show];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];

    [operation setCompletionBlockWithSuccess:
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         // SUCCESS
         
         self.movies = responseObject[@"movies"];
         [self.moviesTableView reloadData];
         
         [self.errorView setHidden:YES];
         [GSProgressHUD dismiss];
     }
                                     failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
        // FAILURE
         
        [self.errorView setHidden:NO];
        [GSProgressHUD dismiss];
     }];
    
    [operation start];
    
    return nil;
}

# pragma mark - TableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //NSLog(@"cell for row at index path: %d", indexPath.row);
    
    static NSString *cellIdentifier = @"MovieTableViewCell";
    MovieTableViewCell *cell = [self.moviesTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Customize cell
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [AVHexColor colorWithHexString:@"#8B9DC3"];
    bgColorView.layer.masksToBounds = YES;
    cell.selectedBackgroundView = bgColorView;
    cell.backgroundColor = [AVHexColor colorWithHexString:@"#F7F7F7"];
    
    NSDictionary *movie = self.movies[indexPath.row];
    
    // Movie Title
    cell.movieTitleLabel.text = movie[@"title"];
    
    // Movie Synopsis
    cell.movieSynopsisLabel.text = movie[@"synopsis"];
    
    // Movie Thumbnail
    [cell.moviePosterImageView setAlpha:0.0f];
    [cell.moviePosterImageView
     setImageWithURL:[NSURL URLWithString:movie[@"posters"][@"thumbnail"]]
     placeholderImage:[UIImage imageNamed:@"MovieImagePlaceholder"]
     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
         // Fade in image
         [UIView beginAnimations:@"fade in" context:nil];
         [UIView setAnimationDuration:1.0];
         [cell.moviePosterImageView setAlpha:1.0f];
         [UIView commitAnimations];
     }
     usingActivityIndicatorStyle: UIActivityIndicatorViewStyleWhite
     ];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //NSLog(@"cell is selected for row at index path: %d", indexPath.row);
    
    MovieViewController *vc = [[MovieViewController alloc] init];
    
    //NSLog(@"%@", self.movies[indexPath.row]);
    vc.movie = self.movies[indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end