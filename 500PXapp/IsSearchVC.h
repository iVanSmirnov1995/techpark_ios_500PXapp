//
//  IsSearchVC.h
//  500PXapp
//
//  Created by Максим Стегниенко on 20.10.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IsSearchVC : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *photoSegmentedControl;
- (IBAction)actionSegmentedControl:(id)sender;





@end
