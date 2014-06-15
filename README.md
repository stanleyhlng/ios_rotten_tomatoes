ios_rotten_tomatoes
===================

Rotten Tomatoes iOS App

This is an iOS application, which shows "Top Rentals" and "Box Office" movies using Rotten Tomatoes APIs.

## Walkthrough of all user stories

[![image](https://raw.githubusercontent.com/wiki/stanleyhlng/ios_rotten_tomatoes/assets/ios_rotten_tomatoes_2.gif)](https://raw.githubusercontent.com/wiki/stanleyhlng/ios_rotten_tomatoes/assets/ios_rotten_tomatoes_2.gif)

## Completed user stories

  * [x] User can view a list of movies from Rotten Tomatoes.  Poster images must be loading asynchronously.
  * [x] User can view movie details by tapping on a cell
  * [x] User sees loading state while waiting for movies API.  You can use one of the 3rd party libraries here.
  * [x] User sees error message when there's a networking error.  You may not use UIAlertView to display the error.  See this screenshot for what the error message should look like: network error screenshot.
  * [x] User can pull to refresh the movie list.
  * [x] Optional: All images fade in.
  * [x] Optional: For the large poster, load the low-res image first, switch to high-res when complete.
  * [x] Optional: All images should be cached in memory and disk. In other words, images load immediately upon cold start.    * [x] Optional: Customize the highlight and selection effect of the cell.
  * [x] Optional: Customize the navigation bar.
  * [x] Optional: Add a tab bar for Box Office and DVD.

## Time spent
10 hours spent in total

## Libraries
```
platform :ios, '7.0'

pod 'AFNetworking', '~> 2.2'
pod 'GSProgressHUD', '~> 0.2'
pod 'Reveal-iOS-SDK', '~> 1.0.4'
pod 'SDWebImage', '~> 3.6'
pod 'UIActivityIndicator-for-SDWebImage', '~> 1.0.5'
pod 'AVHexColor', '~> 1.2.0'
```
