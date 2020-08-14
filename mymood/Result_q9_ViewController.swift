//
//  Result_q9_ViewController.swift
//  myAlamofire
//
//  Created by Manasawee Kaenampornpan on 2/5/2563 BE.
//  Copyright © 2563 iClassroom510-30. All rights reserved.
//

import UIKit

class Result_q9_ViewController: UIViewController {

    @IBOutlet weak var neverRadio_9q_a1: UIButton!
    @IBOutlet weak var someRadio_9q_a1: UIButton!
    @IBOutlet weak var oftenRadio_9q_a1: UIButton!
    @IBOutlet weak var alwaysRadio_9q_a1: UIButton!

    @IBOutlet weak var neverRadio_9q_a2: UIButton!
    @IBOutlet weak var someRadio_9q_a2: UIButton!
    @IBOutlet weak var oftenRadio_9q_a2: UIButton!
    @IBOutlet weak var alwaysRadio_9q_a2: UIButton!

    @IBOutlet weak var neverRadio_9q_a3: UIButton!
    @IBOutlet weak var someRadio_9q_a3: UIButton!
    @IBOutlet weak var oftenRadio_9q_a3: UIButton!
    @IBOutlet weak var alwaysRadio_9q_a3: UIButton!

    @IBOutlet weak var neverRadio_9q_a4: UIButton!
    @IBOutlet weak var someRadio_9q_a4: UIButton!
    @IBOutlet weak var oftenRadio_9q_a4: UIButton!
    @IBOutlet weak var alwaysRadio_9q_a4: UIButton!

    @IBOutlet weak var neverRadio_9q_a5: UIButton!
    @IBOutlet weak var someRadio_9q_a5: UIButton!
    @IBOutlet weak var oftenRadio_9q_a5: UIButton!
    @IBOutlet weak var alwaysRadio_9q_a5: UIButton!

    @IBOutlet weak var neverRadio_9q_a6: UIButton!
    @IBOutlet weak var someRadio_9q_a6: UIButton!
    @IBOutlet weak var oftenRadio_9q_a6: UIButton!
    @IBOutlet weak var alwaysRadio_9q_a6: UIButton!

    @IBOutlet weak var neverRadio_9q_a7: UIButton!
    @IBOutlet weak var someRadio_9q_a7: UIButton!
    @IBOutlet weak var oftenRadio_9q_a7: UIButton!
    @IBOutlet weak var alwaysRadio_9q_a7: UIButton!

    @IBOutlet weak var neverRadio_9q_a8: UIButton!
    @IBOutlet weak var someRadio_9q_a8: UIButton!
    @IBOutlet weak var oftenRadio_9q_a8: UIButton!
    @IBOutlet weak var alwaysRadio_9q_a8: UIButton!

    @IBOutlet weak var neverRadio_9q_a9: UIButton!
    @IBOutlet weak var someRadio_9q_a9: UIButton!
    @IBOutlet weak var oftenRadio_9q_a9: UIButton!
    @IBOutlet weak var alwaysRadio_9q_a9: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func save(_ sender: UIButton) {
        print("9q save")
    }
    
    @IBAction func check_neverRadio_9q_a1(_ sender: UIButton) {
                if someRadio_9q_a1.isSelected {
                       someRadio_9q_a1.isSelected = false
                neverRadio_9q_a1.isSelected = true
                    }
                else if oftenRadio_9q_a1.isSelected {
                       oftenRadio_9q_a1.isSelected = false
                neverRadio_9q_a1.isSelected = true
                    }
                else if alwaysRadio_9q_a1.isSelected {
                       alwaysRadio_9q_a1.isSelected = false
                neverRadio_9q_a1.isSelected = true
                    }
                else {
                        neverRadio_9q_a1.isSelected  = true
                    }
         }
         
         @IBAction func check_someRadio_9q_a1(_ sender: UIButton) {
                if neverRadio_9q_a1.isSelected {
                       neverRadio_9q_a1.isSelected = false
                someRadio_9q_a1.isSelected = true
                    }
                else if oftenRadio_9q_a1.isSelected {
                       oftenRadio_9q_a1.isSelected = false
                someRadio_9q_a1.isSelected = true
                    }
                else if alwaysRadio_9q_a1.isSelected {
                       alwaysRadio_9q_a1.isSelected = false
                someRadio_9q_a1.isSelected = true
                    }
                else {
                        someRadio_9q_a1.isSelected  = true
                    }
             
         }
    @IBAction func check_oftenRadio_9q_a1(_ sender: UIButton) {
           if someRadio_9q_a1.isSelected {
                  someRadio_9q_a1.isSelected = false
           oftenRadio_9q_a1.isSelected = true
               }
           else if neverRadio_9q_a1.isSelected {
                  neverRadio_9q_a1.isSelected = false
           oftenRadio_9q_a1.isSelected = true
               }
           else if alwaysRadio_9q_a1.isSelected {
                  alwaysRadio_9q_a1.isSelected = false
           oftenRadio_9q_a1.isSelected = true
               }
           else {
                   oftenRadio_9q_a1.isSelected  = true
               }
    }
    
    @IBAction func check_alwaysRadio_9q_a1(_ sender: UIButton) {
           if someRadio_9q_a1.isSelected {
                  someRadio_9q_a1.isSelected = false
           alwaysRadio_9q_a1.isSelected = true
               }
           else if oftenRadio_9q_a1.isSelected {
                  oftenRadio_9q_a1.isSelected = false
           alwaysRadio_9q_a1.isSelected = true
               }
           else if neverRadio_9q_a1.isSelected {
                  neverRadio_9q_a1.isSelected = false
           alwaysRadio_9q_a1.isSelected = true
               }
           else {
                   alwaysRadio_9q_a1.isSelected  = true
               }
    }
    
    @IBAction func check_neverRadio_9q_a2(_ sender: UIButton) {
                   if someRadio_9q_a2.isSelected {
                          someRadio_9q_a2.isSelected = false
                   neverRadio_9q_a2.isSelected = true
                       }
                   else if oftenRadio_9q_a2.isSelected {
                          oftenRadio_9q_a2.isSelected = false
                   neverRadio_9q_a2.isSelected = true
                       }
                   else if alwaysRadio_9q_a2.isSelected {
                          alwaysRadio_9q_a2.isSelected = false
                   neverRadio_9q_a2.isSelected = true
                       }
                   else {
                           neverRadio_9q_a2.isSelected  = true
                       }
            }
            
            @IBAction func check_someRadio_9q_a2(_ sender: UIButton) {
                   if neverRadio_9q_a2.isSelected {
                          neverRadio_9q_a2.isSelected = false
                   someRadio_9q_a2.isSelected = true
                       }
                   else if oftenRadio_9q_a2.isSelected {
                          oftenRadio_9q_a2.isSelected = false
                   someRadio_9q_a2.isSelected = true
                       }
                   else if alwaysRadio_9q_a2.isSelected {
                          alwaysRadio_9q_a2.isSelected = false
                   someRadio_9q_a2.isSelected = true
                       }
                   else {
                           someRadio_9q_a2.isSelected  = true
                       }
                
            }
       @IBAction func check_oftenRadio_9q_a2(_ sender: UIButton) {
              if someRadio_9q_a2.isSelected {
                     someRadio_9q_a2.isSelected = false
              oftenRadio_9q_a2.isSelected = true
                  }
              else if neverRadio_9q_a2.isSelected {
                     neverRadio_9q_a2.isSelected = false
              oftenRadio_9q_a2.isSelected = true
                  }
              else if alwaysRadio_9q_a2.isSelected {
                     alwaysRadio_9q_a2.isSelected = false
              oftenRadio_9q_a2.isSelected = true
                  }
              else {
                      oftenRadio_9q_a2.isSelected  = true
                  }
       }
       
       @IBAction func check_alwaysRadio_9q_a2(_ sender: UIButton) {
              if someRadio_9q_a2.isSelected {
                     someRadio_9q_a2.isSelected = false
              alwaysRadio_9q_a2.isSelected = true
                  }
              else if oftenRadio_9q_a2.isSelected {
                     oftenRadio_9q_a2.isSelected = false
              alwaysRadio_9q_a2.isSelected = true
                  }
              else if neverRadio_9q_a2.isSelected {
                     neverRadio_9q_a2.isSelected = false
              alwaysRadio_9q_a2.isSelected = true
                  }
              else {
                      alwaysRadio_9q_a2.isSelected  = true
                  }
       }
    
    @IBAction func check_neverRadio_9q_a3(_ sender: UIButton) {
                   if someRadio_9q_a3.isSelected {
                          someRadio_9q_a3.isSelected = false
                   neverRadio_9q_a3.isSelected = true
                       }
                   else if oftenRadio_9q_a3.isSelected {
                          oftenRadio_9q_a3.isSelected = false
                   neverRadio_9q_a3.isSelected = true
                       }
                   else if alwaysRadio_9q_a3.isSelected {
                          alwaysRadio_9q_a3.isSelected = false
                   neverRadio_9q_a3.isSelected = true
                       }
                   else {
                           neverRadio_9q_a3.isSelected  = true
                       }
            }
            
            @IBAction func check_someRadio_9q_a3(_ sender: UIButton) {
                   if neverRadio_9q_a3.isSelected {
                          neverRadio_9q_a3.isSelected = false
                   someRadio_9q_a3.isSelected = true
                       }
                   else if oftenRadio_9q_a3.isSelected {
                          oftenRadio_9q_a3.isSelected = false
                   someRadio_9q_a3.isSelected = true
                       }
                   else if alwaysRadio_9q_a3.isSelected {
                          alwaysRadio_9q_a3.isSelected = false
                   someRadio_9q_a3.isSelected = true
                       }
                   else {
                           someRadio_9q_a3.isSelected  = true
                       }
                
            }
       @IBAction func check_oftenRadio_9q_a3(_ sender: UIButton) {
              if someRadio_9q_a3.isSelected {
                     someRadio_9q_a3.isSelected = false
              oftenRadio_9q_a3.isSelected = true
                  }
              else if neverRadio_9q_a3.isSelected {
                     neverRadio_9q_a3.isSelected = false
              oftenRadio_9q_a3.isSelected = true
                  }
              else if alwaysRadio_9q_a3.isSelected {
                     alwaysRadio_9q_a3.isSelected = false
              oftenRadio_9q_a3.isSelected = true
                  }
              else {
                      oftenRadio_9q_a3.isSelected  = true
                  }
       }
       
       @IBAction func check_alwaysRadio_9q_a3(_ sender: UIButton) {
              if someRadio_9q_a3.isSelected {
                     someRadio_9q_a3.isSelected = false
              alwaysRadio_9q_a3.isSelected = true
                  }
              else if oftenRadio_9q_a3.isSelected {
                     oftenRadio_9q_a3.isSelected = false
              alwaysRadio_9q_a3.isSelected = true
                  }
              else if neverRadio_9q_a3.isSelected {
                     neverRadio_9q_a3.isSelected = false
              alwaysRadio_9q_a3.isSelected = true
                  }
              else {
                      alwaysRadio_9q_a3.isSelected  = true
                  }
       }
    
    @IBAction func check_neverRadio_9q_a4(_ sender: UIButton) {
                   if someRadio_9q_a4.isSelected {
                          someRadio_9q_a4.isSelected = false
                   neverRadio_9q_a4.isSelected = true
                       }
                   else if oftenRadio_9q_a4.isSelected {
                          oftenRadio_9q_a4.isSelected = false
                   neverRadio_9q_a4.isSelected = true
                       }
                   else if alwaysRadio_9q_a4.isSelected {
                          alwaysRadio_9q_a4.isSelected = false
                   neverRadio_9q_a4.isSelected = true
                       }
                   else {
                           neverRadio_9q_a4.isSelected  = true
                       }
            }
            
            @IBAction func check_someRadio_9q_a4(_ sender: UIButton) {
                   if neverRadio_9q_a4.isSelected {
                          neverRadio_9q_a4.isSelected = false
                   someRadio_9q_a4.isSelected = true
                       }
                   else if oftenRadio_9q_a4.isSelected {
                          oftenRadio_9q_a4.isSelected = false
                   someRadio_9q_a4.isSelected = true
                       }
                   else if alwaysRadio_9q_a4.isSelected {
                          alwaysRadio_9q_a4.isSelected = false
                   someRadio_9q_a4.isSelected = true
                       }
                   else {
                           someRadio_9q_a4.isSelected  = true
                       }
                
            }
       @IBAction func check_oftenRadio_9q_a4(_ sender: UIButton) {
              if someRadio_9q_a4.isSelected {
                     someRadio_9q_a4.isSelected = false
              oftenRadio_9q_a4.isSelected = true
                  }
              else if neverRadio_9q_a4.isSelected {
                     neverRadio_9q_a4.isSelected = false
              oftenRadio_9q_a4.isSelected = true
                  }
              else if alwaysRadio_9q_a4.isSelected {
                     alwaysRadio_9q_a4.isSelected = false
              oftenRadio_9q_a4.isSelected = true
                  }
              else {
                      oftenRadio_9q_a4.isSelected  = true
                  }
       }
       
       @IBAction func check_alwaysRadio_9q_a4(_ sender: UIButton) {
              if someRadio_9q_a4.isSelected {
                     someRadio_9q_a4.isSelected = false
              alwaysRadio_9q_a4.isSelected = true
                  }
              else if oftenRadio_9q_a4.isSelected {
                     oftenRadio_9q_a4.isSelected = false
              alwaysRadio_9q_a4.isSelected = true
                  }
              else if neverRadio_9q_a4.isSelected {
                     neverRadio_9q_a4.isSelected = false
              alwaysRadio_9q_a4.isSelected = true
                  }
              else {
                      alwaysRadio_9q_a4.isSelected  = true
                  }
       }
    
    @IBAction func check_neverRadio_9q_a5(_ sender: UIButton) {
                if someRadio_9q_a5.isSelected {
                       someRadio_9q_a5.isSelected = false
                neverRadio_9q_a5.isSelected = true
                    }
                else if oftenRadio_9q_a5.isSelected {
                       oftenRadio_9q_a5.isSelected = false
                neverRadio_9q_a5.isSelected = true
                    }
                else if alwaysRadio_9q_a5.isSelected {
                       alwaysRadio_9q_a5.isSelected = false
                neverRadio_9q_a5.isSelected = true
                    }
                else {
                        neverRadio_9q_a5.isSelected  = true
                    }
         }
         
         @IBAction func check_someRadio_9q_a5(_ sender: UIButton) {
                if neverRadio_9q_a5.isSelected {
                       neverRadio_9q_a5.isSelected = false
                someRadio_9q_a5.isSelected = true
                    }
                else if oftenRadio_9q_a5.isSelected {
                       oftenRadio_9q_a5.isSelected = false
                someRadio_9q_a5.isSelected = true
                    }
                else if alwaysRadio_9q_a5.isSelected {
                       alwaysRadio_9q_a5.isSelected = false
                someRadio_9q_a5.isSelected = true
                    }
                else {
                        someRadio_9q_a5.isSelected  = true
                    }
             
         }
    @IBAction func check_oftenRadio_9q_a5(_ sender: UIButton) {
           if someRadio_9q_a5.isSelected {
                  someRadio_9q_a5.isSelected = false
           oftenRadio_9q_a5.isSelected = true
               }
           else if neverRadio_9q_a5.isSelected {
                  neverRadio_9q_a5.isSelected = false
           oftenRadio_9q_a5.isSelected = true
               }
           else if alwaysRadio_9q_a5.isSelected {
                  alwaysRadio_9q_a5.isSelected = false
           oftenRadio_9q_a5.isSelected = true
               }
           else {
                   oftenRadio_9q_a5.isSelected  = true
               }
    }
    
    @IBAction func check_alwaysRadio_9q_a5(_ sender: UIButton) {
           if someRadio_9q_a5.isSelected {
                  someRadio_9q_a5.isSelected = false
           alwaysRadio_9q_a5.isSelected = true
               }
           else if oftenRadio_9q_a5.isSelected {
                  oftenRadio_9q_a5.isSelected = false
           alwaysRadio_9q_a5.isSelected = true
               }
           else if neverRadio_9q_a5.isSelected {
                  neverRadio_9q_a5.isSelected = false
           alwaysRadio_9q_a5.isSelected = true
               }
           else {
                   alwaysRadio_9q_a5.isSelected  = true
               }
    }
    
    @IBAction func check_neverRadio_9q_a6(_ sender: UIButton) {
                if someRadio_9q_a6.isSelected {
                       someRadio_9q_a6.isSelected = false
                neverRadio_9q_a6.isSelected = true
                    }
                else if oftenRadio_9q_a6.isSelected {
                       oftenRadio_9q_a6.isSelected = false
                neverRadio_9q_a6.isSelected = true
                    }
                else if alwaysRadio_9q_a6.isSelected {
                       alwaysRadio_9q_a6.isSelected = false
                neverRadio_9q_a6.isSelected = true
                    }
                else {
                        neverRadio_9q_a6.isSelected  = true
                    }
         }
         
         @IBAction func check_someRadio_9q_a6(_ sender: UIButton) {
                if neverRadio_9q_a6.isSelected {
                       neverRadio_9q_a6.isSelected = false
                someRadio_9q_a6.isSelected = true
                    }
                else if oftenRadio_9q_a6.isSelected {
                       oftenRadio_9q_a6.isSelected = false
                someRadio_9q_a6.isSelected = true
                    }
                else if alwaysRadio_9q_a6.isSelected {
                       alwaysRadio_9q_a6.isSelected = false
                someRadio_9q_a6.isSelected = true
                    }
                else {
                        someRadio_9q_a6.isSelected  = true
                    }
             
         }
    @IBAction func check_oftenRadio_9q_a6(_ sender: UIButton) {
           if someRadio_9q_a6.isSelected {
                  someRadio_9q_a6.isSelected = false
           oftenRadio_9q_a6.isSelected = true
               }
           else if neverRadio_9q_a6.isSelected {
                  neverRadio_9q_a6.isSelected = false
           oftenRadio_9q_a6.isSelected = true
               }
           else if alwaysRadio_9q_a6.isSelected {
                  alwaysRadio_9q_a6.isSelected = false
           oftenRadio_9q_a6.isSelected = true
               }
           else {
                   oftenRadio_9q_a6.isSelected  = true
               }
    }
    
    @IBAction func check_alwaysRadio_9q_a6(_ sender: UIButton) {
           if someRadio_9q_a6.isSelected {
                  someRadio_9q_a6.isSelected = false
           alwaysRadio_9q_a6.isSelected = true
               }
           else if oftenRadio_9q_a6.isSelected {
                  oftenRadio_9q_a6.isSelected = false
           alwaysRadio_9q_a6.isSelected = true
               }
           else if neverRadio_9q_a6.isSelected {
                  neverRadio_9q_a6.isSelected = false
           alwaysRadio_9q_a6.isSelected = true
               }
           else {
                   alwaysRadio_9q_a6.isSelected  = true
               }
    }
    
    @IBAction func check_neverRadio_9q_a7(_ sender: UIButton) {
                if someRadio_9q_a7.isSelected {
                       someRadio_9q_a7.isSelected = false
                neverRadio_9q_a7.isSelected = true
                    }
                else if oftenRadio_9q_a7.isSelected {
                       oftenRadio_9q_a7.isSelected = false
                neverRadio_9q_a7.isSelected = true
                    }
                else if alwaysRadio_9q_a7.isSelected {
                       alwaysRadio_9q_a7.isSelected = false
                neverRadio_9q_a7.isSelected = true
                    }
                else {
                        neverRadio_9q_a7.isSelected  = true
                    }
         }
         
         @IBAction func check_someRadio_9q_a7(_ sender: UIButton) {
                if neverRadio_9q_a7.isSelected {
                       neverRadio_9q_a7.isSelected = false
                someRadio_9q_a7.isSelected = true
                    }
                else if oftenRadio_9q_a7.isSelected {
                       oftenRadio_9q_a7.isSelected = false
                someRadio_9q_a7.isSelected = true
                    }
                else if alwaysRadio_9q_a7.isSelected {
                       alwaysRadio_9q_a7.isSelected = false
                someRadio_9q_a7.isSelected = true
                    }
                else {
                        someRadio_9q_a7.isSelected  = true
                    }
             
         }
    @IBAction func check_oftenRadio_9q_a7(_ sender: UIButton) {
           if someRadio_9q_a7.isSelected {
                  someRadio_9q_a7.isSelected = false
           oftenRadio_9q_a7.isSelected = true
               }
           else if neverRadio_9q_a7.isSelected {
                  neverRadio_9q_a7.isSelected = false
           oftenRadio_9q_a7.isSelected = true
               }
           else if alwaysRadio_9q_a7.isSelected {
                  alwaysRadio_9q_a7.isSelected = false
           oftenRadio_9q_a7.isSelected = true
               }
           else {
                   oftenRadio_9q_a7.isSelected  = true
               }
    }
    
    @IBAction func check_alwaysRadio_9q_a7(_ sender: UIButton) {
           if someRadio_9q_a7.isSelected {
                  someRadio_9q_a7.isSelected = false
           alwaysRadio_9q_a7.isSelected = true
               }
           else if oftenRadio_9q_a7.isSelected {
                  oftenRadio_9q_a7.isSelected = false
           alwaysRadio_9q_a7.isSelected = true
               }
           else if neverRadio_9q_a7.isSelected {
                  neverRadio_9q_a7.isSelected = false
           alwaysRadio_9q_a7.isSelected = true
               }
           else {
                   alwaysRadio_9q_a7.isSelected  = true
               }
    }
    
    @IBAction func check_neverRadio_9q_a8(_ sender: UIButton) {
                if someRadio_9q_a8.isSelected {
                       someRadio_9q_a8.isSelected = false
                neverRadio_9q_a8.isSelected = true
                    }
                else if oftenRadio_9q_a8.isSelected {
                       oftenRadio_9q_a8.isSelected = false
                neverRadio_9q_a8.isSelected = true
                    }
                else if alwaysRadio_9q_a8.isSelected {
                       alwaysRadio_9q_a8.isSelected = false
                neverRadio_9q_a8.isSelected = true
                    }
                else {
                        neverRadio_9q_a8.isSelected  = true
                    }
         }
         
         @IBAction func check_someRadio_9q_a8(_ sender: UIButton) {
                if neverRadio_9q_a8.isSelected {
                       neverRadio_9q_a8.isSelected = false
                someRadio_9q_a8.isSelected = true
                    }
                else if oftenRadio_9q_a8.isSelected {
                       oftenRadio_9q_a8.isSelected = false
                someRadio_9q_a8.isSelected = true
                    }
                else if alwaysRadio_9q_a8.isSelected {
                       alwaysRadio_9q_a8.isSelected = false
                someRadio_9q_a8.isSelected = true
                    }
                else {
                        someRadio_9q_a8.isSelected  = true
                    }
             
         }
    @IBAction func check_oftenRadio_9q_a8(_ sender: UIButton) {
           if someRadio_9q_a8.isSelected {
                  someRadio_9q_a8.isSelected = false
           oftenRadio_9q_a8.isSelected = true
               }
           else if neverRadio_9q_a8.isSelected {
                  neverRadio_9q_a8.isSelected = false
           oftenRadio_9q_a8.isSelected = true
               }
           else if alwaysRadio_9q_a8.isSelected {
                  alwaysRadio_9q_a8.isSelected = false
           oftenRadio_9q_a8.isSelected = true
               }
           else {
                   oftenRadio_9q_a8.isSelected  = true
               }
    }
    
    @IBAction func check_alwaysRadio_9q_a8(_ sender: UIButton) {
           if someRadio_9q_a8.isSelected {
                  someRadio_9q_a8.isSelected = false
           alwaysRadio_9q_a8.isSelected = true
               }
           else if oftenRadio_9q_a8.isSelected {
                  oftenRadio_9q_a8.isSelected = false
           alwaysRadio_9q_a8.isSelected = true
               }
           else if neverRadio_9q_a8.isSelected {
                  neverRadio_9q_a8.isSelected = false
           alwaysRadio_9q_a8.isSelected = true
               }
           else {
                   alwaysRadio_9q_a8.isSelected  = true
               }
    }
    
    @IBAction func check_neverRadio_9q_a9(_ sender: UIButton) {
                if someRadio_9q_a9.isSelected {
                       someRadio_9q_a9.isSelected = false
                neverRadio_9q_a9.isSelected = true
                    }
                else if oftenRadio_9q_a9.isSelected {
                       oftenRadio_9q_a9.isSelected = false
                neverRadio_9q_a9.isSelected = true
                    }
                else if alwaysRadio_9q_a9.isSelected {
                       alwaysRadio_9q_a9.isSelected = false
                neverRadio_9q_a9.isSelected = true
                    }
                else {
                        neverRadio_9q_a9.isSelected  = true
                    }
         }
         
         @IBAction func check_someRadio_9q_a9(_ sender: UIButton) {
                if neverRadio_9q_a9.isSelected {
                       neverRadio_9q_a9.isSelected = false
                someRadio_9q_a9.isSelected = true
                    }
                else if oftenRadio_9q_a9.isSelected {
                       oftenRadio_9q_a9.isSelected = false
                someRadio_9q_a9.isSelected = true
                    }
                else if alwaysRadio_9q_a9.isSelected {
                       alwaysRadio_9q_a9.isSelected = false
                someRadio_9q_a9.isSelected = true
                    }
                else {
                        someRadio_9q_a9.isSelected  = true
                    }
             
         }
    @IBAction func check_oftenRadio_9q_a9(_ sender: UIButton) {
           if someRadio_9q_a9.isSelected {
                  someRadio_9q_a9.isSelected = false
           oftenRadio_9q_a9.isSelected = true
               }
           else if neverRadio_9q_a9.isSelected {
                  neverRadio_9q_a9.isSelected = false
           oftenRadio_9q_a9.isSelected = true
               }
           else if alwaysRadio_9q_a9.isSelected {
                  alwaysRadio_9q_a9.isSelected = false
           oftenRadio_9q_a9.isSelected = true
               }
           else {
                   oftenRadio_9q_a9.isSelected  = true
               }
    }
    
    @IBAction func check_alwaysRadio_9q_a9(_ sender: UIButton) {
           if someRadio_9q_a9.isSelected {
                  someRadio_9q_a9.isSelected = false
           alwaysRadio_9q_a9.isSelected = true
               }
           else if oftenRadio_9q_a9.isSelected {
                  oftenRadio_9q_a9.isSelected = false
           alwaysRadio_9q_a9.isSelected = true
               }
           else if neverRadio_9q_a9.isSelected {
                  neverRadio_9q_a9.isSelected = false
           alwaysRadio_9q_a9.isSelected = true
               }
           else {
                   alwaysRadio_9q_a9.isSelected  = true
               }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
