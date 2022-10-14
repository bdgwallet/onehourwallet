//
//  OneHourWalletApp.swift
//  OneHourWallet
//
//  Created by Daniel Nordh on 14/10/2022.
//

import SwiftUI
import BDKManager

@main
struct OneHourWalletApp: App {
    @ObservedObject var bdkManager: BDKManager
    
    init() {
        let network = Network.testnet
        let syncSource = SyncSource(type: SyncSourceType.esplora, customUrl: nil)
        let database = Database(type: DatabaseType.memory, path: nil, treeName: nil)
        bdkManager = BDKManager.init(network: network, syncSource: syncSource, database: database)
    }
    var body: some Scene {
        WindowGroup {
            if bdkManager.wallet == nil {
                CreateWalletView()
                    .environmentObject(bdkManager)
            } else {
                HomeView()
                    .environmentObject(bdkManager)
            }
        }
    }
}
