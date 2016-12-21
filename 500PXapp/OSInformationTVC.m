//
//  OSInformationTVC.m
//  500PXapp
//
//  Created by user on 21.12.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "OSInformationTVC.h"
#import "OSInformationCellTVC.h"
#import "ISServerManager.h"

@interface OSInformationTVC () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableDictionary* information;
@property (strong, nonatomic) NSArray* keys;

@end

@implementation OSInformationTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.information = [NSMutableDictionary dictionary];
    self.keys = [NSArray array];
    
    [self getInformationFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - API

-(void) getInformationFromServer {
    
    [[ISServerManager sharedManager]
     getUserOnID:self.userID
     onSuccess:^(NSDictionary* user) {
         
         if(![[user objectForKey:@"country"] isEqual:@""] && ![[user objectForKey:@"country"] isEqual:[NSNull null]]) {
             [self.information setValue:[user objectForKey:@"country"] forKey:@"Страна:"];
         }
         
         if(![[user objectForKey:@"state"] isEqual:@""] && ![[user objectForKey:@"state"] isEqual:[NSNull null]]) {
             [self.information setValue:[user objectForKey:@"state"] forKey:@"Область:"];
         }
         
         if(![[user objectForKey:@"city"] isEqual:@""] && ![[user objectForKey:@"city"] isEqual:[NSNull null]]) {
             [self.information setValue:[user objectForKey:@"city"] forKey:@"Город:"];
         }
         
         if(![[user objectForKey:@"birthday"] isEqual:[NSNull null]]) {
             [self.information setValue:[user objectForKey:@"birthday"] forKey:@"День рождения:"];
         }
         
         if(![[user objectForKey:@"sex"] isEqual:[NSNull null]]) {
             NSInteger sex = [[user objectForKey:@"sex"] integerValue];
             switch (sex) {
                 case 0:
                     break;
                 case 1:
                     [self.information setValue:@"Мужской" forKey:@"Пол:"];
                     break;
                 case 2:
                     [self.information setValue:@"Женский" forKey:@"Пол:"];
                     break;
                 default:
                     break;
             }
         }
         self.keys = [self.information allKeys];
         
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.tableView reloadData];
         });
    } onFailure:^(NSError* error, NSInteger statusCode) {
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.information.count;
}


- (OSInformationCellTVC *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OSInformationCellTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    OSInformationCellModel* model = [[OSInformationCellModel alloc] init];
    
    model.key = self.keys[row];
    model.value = [self.information objectForKey:self.keys[row]];
    
    [cell fillCellWithModel:model];

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
