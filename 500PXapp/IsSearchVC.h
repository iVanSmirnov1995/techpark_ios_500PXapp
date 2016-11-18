//
//  IsSearchVC.h
//  500PXapp
//
//  Created by Максим Стегниенко on 20.10.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

<<<<<<< HEAD
@interface IsSearchVC : UIViewController
=======
@interface IsSearchVC : UIViewController <UITextFieldDelegate>
>>>>>>> fb8c30de1a0731aed17dac0bb1540e195168ee12


@property (weak, nonatomic) IBOutlet UITextField *searchField;

<<<<<<< HEAD


=======
- (IBAction)actionTextField:(UITextField *)sender ;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *appearConstrain;
>>>>>>> fb8c30de1a0731aed17dac0bb1540e195168ee12




@end
