//
//  LoginFormController.swift
//  VK
//
//  Created by Sergey Melnik on 11.04.2022.
//

import UIKit
import WebKit

#warning("Singleton вынести в отдельный файл, беспорядок в коде")

class LoginFormController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBAction func loginButtonPressed(_ sender: Any) {
        // получаем текст логина
        let login = loginInput.text!
        // получаем текст пароль
        let password = passwordInput.text!
        // проверяем верны ли они
        if login == "1" && password == "1" {
            print("успешная авторизация")
        } else {
            print("неуспешная авторизация")
        }
    }
    //ID нашего приложения в API VK
    let appId = "8137039"
    
    var webView: WKWebView!
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        // жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        // присваиваем его UIScrollVIew
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        //авторизация
        guard let url = URL (string: "https://oauth.vk.com/authorize?client_id=" + appId + "display=page&redirect_url=https://oauth.vk.com/blank.html&scope=friends,groups,photos&response_type=token&v=5.131state=123456") else { return }
        let requestObj = URLRequest (url: url)
        webView.load(requestObj)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // Проверяем данные
        let checkResult = checkUserData()
        
        // если данные неверны, покажем ошибку
        if !checkResult {
            showLoginError()
        }
        
        // вернем результат
        return checkResult
    }
    
    func checkUserData() -> Bool {
        let login = loginInput.text!
        let password = passwordInput.text!
        
        if login == "1" && password == "1" {
            return true
        } else {
            return false
        }
    }
    
    func showLoginError() {
        // Создаем контроллер
        let alter = UIAlertController(title: "Ошибка", message: "Введены не верные данные пользователя", preferredStyle: .alert)
        // Создаем кнопку для UIAlertController
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        // Добавляем кнопку на UIAlertController
        alter.addAction(action)
        // показываем UIAlertController
        present(alter, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Подписываемся на два уведомления, одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIWindow.keyboardWillShowNotification, object: nil)
        // Второе когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIWindow.keyboardWillHideNotification, object: nil)
        // жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        // присваиваем его UIScrollVIew
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
    }
    //отписываемся
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    // когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
        
        // получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        // добавляем отступ внизу UIScrollView равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    //когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // устанавливаем отступ внизу UIScrollView равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
}

extension LoginFormController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        let urlComponents = fragment.components(separatedBy: "&").map{ $0.components(separatedBy: "=")}
        let token = urlComponents.first {$0.first == "access_token"}?.last
        let userId = urlComponents.first {$0.first == "user_id"}?.last ?? "0"
        guard let accessToken = token else {
            decisionHandler(.allow)
            return
        }
        let userDefaults = UserDefaults.standard //настройки пользователя
        userDefaults.set(accessToken, forKey: "accessToken")
        userDefaults.set(userId, forKey: "userId")
        Singleton.sharedInstance().accessToken = accessToken
        print(accessToken)
        Singleton.sharedInstance().userId = userId
        decisionHandler(.cancel)
        performSegue(withIdentifier: "loginSuccess", sender: self)
    }
}
