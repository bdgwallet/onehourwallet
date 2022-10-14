//
//  ContentView.swift
//  OneHourWallet
//
//  Created by Daniel Nordh on 14/10/2022.
//

import SwiftUI
import WalletUI
import BDKManager
import BitcoinDevKit

struct CreateWalletView: View {
    @EnvironmentObject var bdkManager: BDKManager
    
    var body: some View {
        VStack {
            Spacer()
            Image("BDGseal")
                .resizable()
                .frame(width: 150, height: 150)
            Text("One Hour Wallet")
                .textStyle(BitcoinTitle1())
            Spacer()
            Button("Create new wallet") {
                do {
                    let mnemonic = try generateMnemonic(wordCount: WordCount.words12)
                    let descriptor = bdkManager.descriptorFromMnemonic(descriptorType: DescriptorType.singleKey_wpkh84, mnemonic: mnemonic, password: nil)
                    bdkManager.loadWallet(descriptor: descriptor!)
                } catch let error {
                    print(error)
                }
                
            }.buttonStyle(BitcoinFilled())
                .padding()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CreateWalletView()
    }
}
