//
//  SecondViewController.swift
//  Week6
//
//  Created by 정재욱 on 11/8/23.
//

import UIKit
import Lottie
import Hero

class SecondViewController: UIViewController {
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        button.setTitle("close", for: .normal)
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
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        initView()
        configAutoLayout()
        
        bouncedBall.play()
    }
    
    func initView() {
        view.addSubview(closeButton)
        view.addSubview(bouncedBall)
    }
    
    func configAutoLayout() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        bouncedBall.translatesAutoresizingMaskIntoConstraints = false
        bouncedBall.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        bouncedBall.heightAnchor.constraint(equalTo: bouncedBall.widthAnchor, multiplier: 1).isActive = true
        bouncedBall.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        bouncedBall.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        
    }
    
    @objc
    func closeModal() {
        dismiss(animated: true, completion: nil)
    }
    
}
