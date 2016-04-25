//
//  ViewController.m
//  Contact
//
//  Created by Md Adit Hasan on 4/21/16.
//  Copyright © 2016 Md Adit Hasan. All rights reserved.
//

#import "ContactController.h"

@interface ContactController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic,strong) NSArray *contactArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@end

@implementation ContactController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.delegate = self;
    self.tableView.estimatedRowHeight = 140;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    
    // observing the Contact property for changes
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observeValueForKeyPath:) name:@"GetResponse" object:nil];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     return self.contactArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Contact %ld",(long)(section+1)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [ContactManager returnItemCounts:[self.contactArray objectAtIndex:section]];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"custom"];
    NSArray *item = [ContactManager contentArrayFromDictionary:[self.contactArray objectAtIndex:indexPath.section]];
    [cell.textLabel setText:[item objectAtIndex:indexPath.row]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    ContactController *contact = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactController"];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [contact setContactArray:[NSArray arrayWithObjects:[ContactManager searchInArray:[self.contactArray objectAtIndex:indexPath.section] searchItem:cell.textLabel.text], nil]];
    [self.navigationController pushViewController:contact animated:YES];

}



#pragma mark - observer
- (void)observeValueForKeyPath:(NSNotification *)notification {
    if(notification.object) {
        self.contactArray = [notification object];
        [self.tableView reloadData];
    }

}

#pragma mark - searchBar Delegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if([searchText length]!=0) {
        self.contactArray = [NSMutableArray arrayWithArray:[ContactManager searchObjectsInArray:searchText]];
    } else {
        self.contactArray = [NSMutableArray arrayWithArray:[[ContactManager shareInstance] getContacts]];
    }
    [self.tableView reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
        [self.searchBar resignFirstResponder];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

        [self.searchBar resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
