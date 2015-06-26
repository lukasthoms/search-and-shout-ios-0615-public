//
//  FISSearchViewController.m
//  searchAndShout
//
//  Created by Joe Burgess on 7/2/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISSearchViewController.h"

@interface FISSearchViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *searchTypeSwitch;
@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (strong, nonatomic) NSMutableArray *searchResult;

@end

@implementation FISSearchViewController

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
    self.searchField.delegate = self;
    self.searchTableView.delegate = self;
    self.searchTableView.dataSource = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    FISDataStore *dataStore = [FISDataStore sharedDataStore];
    NSFetchRequest *searchDance = [[NSFetchRequest alloc] initWithEntityName:@"FISDanceMove"];
    self.searchArray = [dataStore.managedObjectContext executeFetchRequest:searchDance error:nil];
    self.searchResult = [@[] mutableCopy];
    if (self.searchTypeSwitch.selectedSegmentIndex == 0)
    {
        for (FISDanceMove *move in self.searchArray) {
            if ([move.name isEqual:self.searchField.text]){
                [self.searchResult addObject: move];
            }
        }
        
    } else {
        for (FISDanceMove *move in self.searchArray) {
            if ([move.step1 isEqual:self.searchField.text] ||
                [move.step2 isEqual:self.searchField.text] ||
                [move.step3 isEqual:self.searchField.text] ||
                [move.step4 isEqual:self.searchField.text]) {
                
                    [self.searchResult addObject: move];
            }
        }
    }
    [self.searchTableView reloadData];
    
    
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResult.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchResultCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.searchResult[indexPath.row] name];
    NSString *move1 = [self.searchResult[indexPath.row] step1];
    NSString *move2 = [self.searchResult[indexPath.row] step2];
    NSString *move3 = [self.searchResult[indexPath.row] step3];
    NSString *move4 = [self.searchResult[indexPath.row] step4];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@, %@, %@", move1, move2, move3, move4];
    return cell;
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
