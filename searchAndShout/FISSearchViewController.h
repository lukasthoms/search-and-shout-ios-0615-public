//
//  FISSearchViewController.h
//  searchAndShout
//
//  Created by Joe Burgess on 7/2/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FISDataStore.h"
#import "FISDanceMove.h"

@interface FISSearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) NSArray *searchArray;

@end
