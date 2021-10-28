//
//  ViewController.swift
//  StudyDemo
//
//  Created by Charron on 2021/10/24.
//

import UIKit

class ViewController: UIViewController {

    

    @IBAction func buttonClick(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let demo1VC:Demo1ViewController? = generateController()
            if let demo1VC = demo1VC {
                navigationController?.pushViewController(demo1VC, animated: true)
            }
            break
        default:
            break
        }
    }
    //MARK:
    private func generateController<T>() -> T?{
        if let demo1VC = T.self as? Demo1ViewController.Type {
            return demo1VC.init() as? T
        }
        return nil
    }
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Study Demo"
        view.backgroundColor = .white
        initUI()
    }
    //MARK: initUI
    private func initUI() {

        layoutSubViews()
    }
    //MARK: 适配View
    private func layoutSubViews() {
        
    }
    
    //MARK: 懒加载
    
}


