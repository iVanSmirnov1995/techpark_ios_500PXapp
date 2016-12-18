//
//  ISTabBarVC.m
//  500PXapp
//
//  Created by Smirnov Ivan on 04.12.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "ISTabBarVC.h"
#import "ISServerManager.h"
#import "ISUser.h"
#import "ISHomeVC.h"
#import "ViewController.h"
#import "ISUserData+CoreDataProperties.h"

@interface ISTabBarVC ()<ISModalDelegate>

@property(strong,nonatomic)ISUser* user;

@end

@implementation ISTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    //UINavigationController* nc=[[UINavigationController alloc]init];
    ISHomeVC* hom=[self.viewControllers[0] topViewController];
    hom.tapVC=self;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ISUserData"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    if (resultArray.count<=0) {
        
        ViewController* vc=[self.storyboard instantiateViewControllerWithIdentifier:@"log"];
        vc.delegate=self;
        [self presentViewController:vc animated:YES completion:nil];
        
    }else{
        
        
        [self loadDataWithResultArray:resultArray];
    
    
    }
}


-(void)loadDataWithResultArray:(NSArray*)resultArray{
    
    
    ISUserData* userData=resultArray[0];
    
    [[ISServerManager sharedManager]setOauthTokenSecret:userData.oauthTokenSecret];
    [[ISServerManager sharedManager]setOauthToken:userData.oauthToken];
    [[ISServerManager sharedManager]getUserOnSuccess:^(ISUser *user) {
        
        [[ISServerManager sharedManager]setUser:user];
        ISHomeVC* vc=[self.viewControllers[0] topViewController];
        [vc startLoad];
       //  [(ISHomeVC*)self.viewControllers[0] startLoad];
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"%@",error);
    }];
    
    
}



#pragma mark-ISModalDelegate


- (void) vcDidDismiss:(ViewController*) vc{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ISUserData"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    if (resultArray.count==1) {
        
        [vc dismissViewControllerAnimated:YES completion:^{
            
            [self loadDataWithResultArray:resultArray];
            
        }];
        
    }
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
