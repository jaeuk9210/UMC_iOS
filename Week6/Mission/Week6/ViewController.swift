//
//  ViewController.swift
//  Week6
//
//  Created by 정재욱 on 11/7/23.
//

import UIKit
import Lottie
import Hero

class ViewController: UIViewController {

    lazy var openButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(openModal), for: .touchUpInside)
        button.setTitle("open", for: .normal)
        button.hero.id = "button"
        return button
    } ()
    
    lazy var bouncedBall: LottieAnimationView = {
        let lottieanimationView = LottieAnimationView(name: "Lottie")
        lottieanimationView.frame = view.bounds
        lottieanimationView.contentMode = .scaleAspectFit
        lottieanimationView.loopMode = .loop
        lottieanimationView.animationSpeed = 1
        lottieanimationView.hero.id = "lottie"
        return lottieanimationView
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        configAutoLayout()
        
        bouncedBall.play()
    }
    
    func initView() {
        view.addSubview(bouncedBall)
        view.addSubview(openButton)
    }
    
    func configAutoLayout() {
        bouncedBall.translatesAutoresizingMaskIntoConstraints = false
        bouncedBall.widthAnchor.constraint(equalToConstant: 100).isActive = true
        bouncedBall.heightAnchor.constraint(equalTo: bouncedBall.widthAnchor, multiplier: 1).isActive = true
        bouncedBall.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        bouncedBall.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        openButton.translatesAutoresizingMaskIntoConstraints = false
        openButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        openButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
    
    @objc
    func openModal() {
        let secondViewControll = SecondViewController()
        secondViewControll.hero.isEnabled = true
        secondViewControll.modalPresentationStyle = .fullScreen
        secondViewControll.hero.modalAnimationType = .selectBy(presenting: .slide(direction: .left), dismissing: .slide(direction: .down))
        
        present(secondViewControll, animated: true, completion: nil)
    }
    
}
