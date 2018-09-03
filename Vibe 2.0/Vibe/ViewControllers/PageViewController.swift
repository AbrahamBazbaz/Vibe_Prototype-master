//
//  PageViewController.swift
//  
//
//  Created by Allan Frederick on 8/4/18.
//  Code from Seemu Apps
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    // Hamburger menu icon
    @IBOutlet weak var menu: UIBarButtonItem!
    
    // Array list for storing view controllers
    lazy var viewControllerList: [UIViewController] = {
        return [self.newVc(viewController: "FriendsList"),
                self.newVc(viewController: "VibeGroups")]
    }()
    
    // Returns previous view controller -> when user swipes to the left
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // Check to get view controller index of the current view controller
        guard let viewControllerIndex = viewControllerList.index(of: viewController)
            // Otherwise return nothing
            else {
            return nil
        }
        // Get previous index of view controller index
        let previousIndex = viewControllerIndex - 1
        
        // If index exceeded bounds of array, return last view controller in array
        // Infinate swipe -> return viewControllerList.last
        // Finite swipe -> return nil
        guard previousIndex >= 0 else{
            return nil
        }
        // Check count of index
        guard viewControllerList.count > previousIndex else{
            return nil
        }
        // If count is greater than previous index, return previous index
        return viewControllerList[previousIndex]
    }
    
     // Returns previous view controller -> when user swipes to the right
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // Check to get view controller index of the current view controller
        guard let viewControllerIndex = viewControllerList.index(of: viewController)
            // Otherwise return nothing
            else {
                return nil
        }
         // Get next index of view controller index
        let nextIndex = viewControllerIndex + 1
        
        // If index exceeded bounds of array, return first view controller in array
        // Infinate swipe -> return viewControllerList.first
        // Finite swipe -> return nil
        guard viewControllerList.count != nextIndex else{
            return nil
        }
        // Check count of index
        guard viewControllerList.count > nextIndex else{
            return nil
        }
        // If count is greater than next index, return next index
        return viewControllerList[nextIndex]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Menu reveal
        
        
        // Set first view controller to first item in view controller array
        // Set up view controller for page view
        self.dataSource = self
        if let firstViewController = viewControllerList.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
            self.navigationController?.navigationBar.isTranslucent = false
        }
    }
    
    // Output specified UI view controller
    func newVc(viewController: String) -> UIViewController{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        menu.target = self.revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
