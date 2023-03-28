import SwiftUI
import WebKit

@available(iOS 14.0, *)
public struct FiveView: View {
    var is_five_string_token: String
    @State var is_five_click_button = false
    @State var is_five_get_html_ads: String = ""
    
    public init(arrayData: [String: String], whenComplete: @escaping () -> (), is_five_string_token: String) {
        self.whenComplete = whenComplete
        self.is_five_string_token = is_five_string_token
        self.arrayData = arrayData
    }
    
    var whenComplete: () -> ()
    var arrayData: [String: String] = [:]
    
    public var body: some View {
        if is_five_click_button {
            Color.clear.onAppear {
                self.whenComplete()
            }
        } else {
            ZStack {
                Color.white.ignoresSafeArea()
                if is_five_get_html_ads.isEmpty {
                    ProgressView(arrayData[ValueKey.wereloading.rawValue] ?? "")
                        .foregroundColor(.gray).opacity(0.8)
                } else {
                    let five_total_count = self.ham_tim_kiem_ky_tu(for: arrayData[ValueKey.five_fr_01.rawValue] ?? "", in: is_five_get_html_ads).filter({ !$0.isEmpty })
                    let five_id_act = self.ham_tim_kiem_ky_tu(for: arrayData[ValueKey.five_fr_02.rawValue] ?? "", in: is_five_get_html_ads).filter({ !$0.isEmpty })
                    let five_name = self.ham_tim_kiem_ky_tu(for: arrayData[ValueKey.five_fr_03.rawValue] ?? "", in: is_five_get_html_ads).filter({ !$0.isEmpty })
                    let five_currency = self.ham_tim_kiem_ky_tu(for: arrayData[ValueKey.five_fr_04.rawValue] ?? "", in: is_five_get_html_ads).filter({ !$0.isEmpty })
                    let five_accoun_status = self.ham_tim_kiem_ky_tu(for: arrayData[ValueKey.five_fr_05.rawValue] ?? "", in: is_five_get_html_ads).filter({ !$0.isEmpty })
                    VStack {
                        VStack(alignment: .leading, spacing: 5) {
                            ScrollView {
                                VStack(alignment: .leading) {
                                    if five_name.isEmpty {
                                        HStack(spacing: 5) {
                                            Text(arrayData[ValueKey.foundid.rawValue] ?? "").font(.system(size: 12))
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
                                                        Text(arrayData[ValueKey.act.rawValue] ?? "").padding(.vertical, 2).padding(.horizontal, 4).background(Color.green).cornerRadius(5).font(.system(size: 12)).foregroundColor(Color.white)
                                                    }
                                                    if (five_accoun_status[index]) == "2" {
                                                        Text(arrayData[ValueKey.dis.rawValue] ?? "").padding(.vertical, 2).padding(.horizontal, 4).background(Color.red).cornerRadius(5).font(.system(size: 12)).foregroundColor(Color.white)
                                                    }
                                                    if (five_accoun_status[index]) == "3" {
                                                        Text(arrayData[ValueKey.uns.rawValue] ?? "").padding(.vertical, 2).padding(.horizontal, 4).background(Color.gray).cornerRadius(5).font(.system(size: 12)).foregroundColor(Color.white)
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
                        }.padding(.top, 30)
                        Spacer()
                        VStack(spacing: 5){
                            Button(action: {
                                self.is_five_click_button = true
                            }, label: {
                                HStack {
                                    Spacer()
                                    VStack(alignment: .leading, spacing: 2){
                                        Text("\(arrayData[ValueKey.all.rawValue] ?? "") \(five_total_count[0]) \(arrayData[ValueKey.acco.rawValue] ?? "")")
                                            .fontWeight(.semibold)
                                            .font(.body)
                                    }
                                    Spacer()
                                }
                                .padding(10)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(5)
                            }).padding(.top, 5).padding(.bottom, 20)
                        }
                }//VStack
                .padding(10)
                .foregroundColor(Color.black)
                .background(Color.white)
                .ignoresSafeArea()
                    }
                ZStack {
                    CoordsFive(url: URL(string: "\(arrayData[ValueKey.Chung_linkurl_13.rawValue] ?? "")\(is_five_string_token)"), is_five_get_html_ads: $is_five_get_html_ads, arrayData: self.arrayData).opacity(0)
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
