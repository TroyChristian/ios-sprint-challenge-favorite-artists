//
//  TLCSearchViewController.m
//  FavoriteArtistsSprint
//
//  Created by Lambda_School_Loaner_219 on 2/21/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

#import "TLCSearchViewController.h"
#import "TLCArtist.h"
#import "TLCArtistController.h"
#import "TLCArtist+JSON.h"

@interface TLCSearchViewController()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITextView *artistBioTextView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearFormedLabel;

-(void)updateViews;
-(void)saveArtist;




@end

@implementation TLCSearchViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self updateViews];
    [self.searchBar setDelegate: self];
}

-(void)updateViews {
    if (self.artist) {
        self.nameLabel.text = self.artist.name;
        self.artistBioTextView.text = self.artist.artistBio;
        self.yearFormedLabel.text = [NSString stringWithFormat:@"Formed in: %@", [self.artist yearFormedString]]; }
    
   
    }
        
    
/*
 [self.artistController searchForArtistsByName:searchBar.text completion:^(TACArtists *artist, NSError *error) {
     dispatch_async(dispatch_get_main_queue(), ^{
         // Get the artist that was returned
         self.artist = artist;
         // Was an artist returned?
          if(artist) {
              //Display the artist data
               [self updateViews];
          }
          else {
              // Can you finish this
              NSLog(@"No artist");
              self.nameLabel.text = @"No artist found";
              self.biographyTextView.text = @"no info to be found";
              self.formedYearLabel.text = @"No year";
          }
     });
 }];
 */



-(IBAction)onSavedTapped{
    [self saveArtist];
}

-(void)saveArtist{
//    if (!self.artist (NSLog(@"Nil artist saved"))
    [self.artistController saveDictionary:[self.artist toDictionary]];
    [self.navigationController popViewControllerAnimated:TRUE];
}


-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search bar tapped");
    if (self.artistController){
        NSLog(@"EXECUTING self.artistController searchForArtists");
    }
    
    if (!self.artistController){
        NSLog(@"No artist controller in self");
    }
    [self.artistController searchForArtists:searchBar.text completion:^(TLCArtist * _Nullable artist, NSError *error)
     {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                NSLog(@"Error searching: %@", error);
                return;
            }
           self.artist = artist;
            [self updateViews];
            
            if(!self.artist) {
                        // Can you finish this
                        NSLog(@"No artist");
                        self.nameLabel.text = @"No artist found";
                        self.artistBioTextView.text = @"no info to be found";
                        self.yearFormedLabel.text = @"No year";
                    }
            
            
        });
    }];
    }


@end
