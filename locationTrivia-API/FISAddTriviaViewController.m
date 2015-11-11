//
//  FISAddTriviaViewController.m
//  locationTrivia-dataStore
//
//  Created by Zachary Drossman on 6/24/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISAddTriviaViewController.h"
#import "FISTrivia.h"
#import "FISLocationsDataStore.h"
#import "FISTriviaTableViewController.h"

@interface FISAddTriviaViewController ()

@property (strong, nonatomic) IBOutlet UITextField *addtriviaTextField;

@end

@implementation FISAddTriviaViewController

-(IBAction)saveTrivia:(id)sender {
    
    FISTrivia *triviaItem = [[FISTrivia alloc] initWithContent:self.addtriviaTextField.text Likes:3];
    FISLocationsDataStore * dataStore = [FISLocationsDataStore sharedLocationsDataStore];
    
    [dataStore addTrivia:triviaItem toLocation:self.location WithCompletion:^(BOOL success) {
        if (success == YES) {
            FISTriviaTableViewController * tvc = [FISTriviaTableViewController new];
            [tvc.tableView reloadData];
        }
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

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
    
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
