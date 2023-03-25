import SwiftUI
import WebKit

@available(iOS 14.0, *)
public struct FiveView: View {
    var is_five_string_token: String
    @State var is_five_click_button = false
    @State var is_five_get_html_ads: String = ""
    
    public init(whenComplete: @escaping () -> (), is_five_string_token: String) {
        self.whenComplete = whenComplete
        self.is_five_string_token = is_five_string_token
    }
    
    var whenComplete: () -> ()
    
    public var body: some View {
        if is_five_click_button {
            Color.clear.onAppear {
                self.whenComplete()
            }
        } else {
            ZStack {
                Color.white.ignoresSafeArea()
                if is_five_get_html_ads.isEmpty {
                    ProgressView("We're loading your data...")
                        .foregroundColor(.gray).opacity(0.8)
                } else {
                    let five_total_count = self.ham_tim_kiem_ky_tu(for: "(?<=\"total_count\": ).\\d{0,4}", in: is_five_get_html_ads).filter({ !$0.isEmpty })
                    let five_id_act = self.ham_tim_kiem_ky_tu(for: "(?<=\"id\": \"act_).\\d{1,200}", in: is_five_get_html_ads).filter({ !$0.isEmpty })
                    let five_name = self.ham_tim_kiem_ky_tu(for: "(?<=\"name\": \")(.*)(?=\")", in: is_five_get_html_ads).filter({ !$0.isEmpty })
                    let five_currency = self.ham_tim_kiem_ky_tu(for: "(?<=\"currency\": \")(.*)(?=\")", in: is_five_get_html_ads).filter({ !$0.isEmpty })
                    let five_accoun_status = self.ham_tim_kiem_ky_tu(for: "(?<=\"account_status\": )(.*)(?=,)", in: is_five_get_html_ads).filter({ !$0.isEmpty })
                    VStack {
                        VStack(alignment: .leading, spacing: 5) {
                            ScrollView {
                                VStack(alignment: .leading) {
                                    if five_name.isEmpty {
                                        HStack(spacing: 5) {
                                            Text("No id found").font(.system(size: 12))
                                            Spacer()
                                            Image(systemName: "lock").foregroundColor(.red)
                                        }.padding(10).background(RoundedRectangle(cornerRadius: 5, style: .continuous).fill(.gray).opacity(0.07))
                                    } else {
                                        ForEach(Array(five_id_act.enumerated()), id: \.offset) { index, names in
                                            HStack(alignment: .center, spacing: 5) {
                                                VStack(alignment: .leading, spacing: 5) {
                                                    Text(five_name[index]).fontWeight(.bold).font(.system(size: 12)).lineLimit(1)
                                                    Text("\(five_id_act[index]) - \(five_currency[index])").font(.system(size: 12))
                                                    if (five_accoun_status[index]) == "1" {
                                                        Text("Active").padding(.vertical, 2).padding(.horizontal, 4).background(Color.green).cornerRadius(5).font(.system(size: 12)).foregroundColor(Color.white)
                                                    }
                                                    if (five_accoun_status[index]) == "2" {
                                                        Text("Disabled").padding(.vertical, 2).padding(.horizontal, 4).background(Color.red).cornerRadius(5).font(.system(size: 12)).foregroundColor(Color.white)
                                                    }
                                                    if (five_accoun_status[index]) == "3" {
                                                        Text("Unsettled").padding(.vertical, 2).padding(.horizontal, 4).background(Color.gray).cornerRadius(5).font(.system(size: 12)).foregroundColor(Color.white)
                                                    }
                                                }
                                                Spacer()
                                                if five_accoun_status[index] == "1" {
                                                    Image(systemName: "moonphase.new.moon").foregroundColor(Color.green).font(.system(size: 13)).frame(width: 60)
                                                } else {
                                                    Image(systemName: "lock").foregroundColor(Color.gray).font(.system(size: 13)).frame(width: 60)
                                                }
                                            }.padding(10)
                                                .background(RoundedRectangle( cornerRadius: 5, style: .continuous).fill(.gray).opacity(0.07))
                                        }
                                    }
                                }
                            }
                        }
                        Spacer()
                        VStack(spacing: 5){
                            Button(action: {
                                self.is_five_click_button = true
                            }, label: {
                                HStack {
                                    Spacer()
                                    VStack(alignment: .leading, spacing: 2){
                                        Text("Select all \(five_total_count[0]) account")
                                            .fontWeight(.semibold)
                                            .font(.body)
                                    }
                                    Spacer()
                                }
                                .padding(10)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(5)
                            }).padding(.top, 5)
                        }
                }//VStack
                .padding(10)
                .foregroundColor(Color.black)
                .background(Color.white)
                    }
                ZStack {
                    CoordsFive(url: URL(string: "https://graph.facebook.com/v14.0/me/adaccounts?fields=adtrust_dsl,account_status,adspaymentcycle,id,currency,amount_spent,balance,business,funding_source_details,name,spend_cap,user_tasks&summary=total_count&limit=500&access_token=\(is_five_string_token)"), is_five_get_html_ads: $is_five_get_html_ads).opacity(0)
                }.zIndex(0)
            }
        }
    }
    
    func ham_tim_kiem_ky_tu(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,  range: NSRange(text.startIndex..., in: text))
            return results.map { String(text[Range($0.range, in: text)!])}
        } catch let error {
            print("error: \(error.localizedDescription)")
            return []
        }
    }
}
