//
//  MoviesViewController.m
//  ios_rotten_tomatoes
//
//  Created by Stanley Ng on 6/8/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "MovieViewController.h"
#import "GSProgressHUD.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "AVHexColor.h"

@interface MoviesViewController ()

@property (weak, nonatomic) IBOutlet UITableView *moviesTableView;
@property (strong, nonatomic) NSArray *movies;
@property (weak, nonatomic) IBOutlet UIView *errorView;

@end

@implementation MoviesViewController

UIRefreshControl *refreshControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Movies";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.moviesTableView.delegate = self;
    self.moviesTableView.dataSource = self;

    //API: Top Rentals

    // [start] fetch data
    [GSProgressHUD show];

    //NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    
    //API: Box Office Movies
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *connectionError)
    {
        if (connectionError == nil) {
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            //NSLog(@"%@", object);
        
            self.movies = object[@"movies"];
            [self.moviesTableView reloadData];
            [self.errorView setHidden:YES];
        }
        else {
            NSLog(@"ERROR");
            [self.errorView setHidden:NO];
        }
        [GSProgressHUD dismiss];
    }];
    // [end] fetch data
    
    [self.moviesTableView registerNib:[UINib nibWithNibName:@"MovieTableViewCell" bundle:nil] forCellReuseIdentifier:@"MovieTableViewCell"];

    self.moviesTableView.rowHeight = 120;
    
    // Pull to Refresh Control
    refreshControl = [[UIRefreshControl alloc] init];
    [self.moviesTableView addSubview:refreshControl];
    [refreshControl addTarget:self
                       action:@selector(refreshTable)
             forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshTable {
    [refreshControl endRefreshing];

    // [start] fetch data
    [GSProgressHUD show];
    
    //NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    
    //API: Box Office Movies
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *connectionError)
     {
         if (connectionError == nil) {
             id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             //NSLog(@"%@", object);
             
             self.movies = object[@"movies"];
             [self.moviesTableView reloadData];
             [self.errorView setHidden:YES];
         }
         else {
             NSLog(@"ERROR");
             [self.errorView setHidden:NO];
         }
         [GSProgressHUD dismiss];
     }];
    // [end] fetch data
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
