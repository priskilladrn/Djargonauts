//
//  MultipeerSession.swift
//  Djargonaut
//
//  Created by Jevon Levin on 21/04/23.
//

import Foundation
import MultipeerConnectivity
import os

// TODO: move to models
struct GameMessageType {
    static var roomSetting = 0, answer = 1, triggerNext = 2, isExplanationCorrect = 3, opponentFinalScore = 4
}
public struct GameMessage: Codable, Equatable, Identifiable {
    public static func == (lhs: GameMessage, rhs: GameMessage) -> Bool {
        return lhs.id == rhs.id
    }
    public var id = UUID()
    var type: Int
    
    var roomSetting: RoomSetting?
    var isAnswerCorrect: Bool = false
    var opponentFinalScore: Int?
}

// TODO: move to models
public struct RoomSetting: Codable {
    var chosenCategory: String = "Technology"
    var duration: Int = 15
    var cardCount: Int = 10
    var words: [JargonModel] = []
}

//TODO: move extensions to its own directory
extension Encodable {
    func encode(with encoder: JSONEncoder = JSONEncoder()) throws -> Data {
        return try encoder.encode(self)
    }
}
extension Decodable {
    static func decode(with decoder: JSONDecoder = JSONDecoder(), from data: Data) throws -> Self {
        return try decoder.decode(Self.self, from: data)
    }
}

class MultipeerSession: NSObject, ObservableObject {
    private let serviceType = "djargonaut-srv"
    private var myPeerID: MCPeerID
    
    public let serviceAdvertiser: MCNearbyServiceAdvertiser
    public let serviceBrowser: MCNearbyServiceBrowser
    public let session: MCSession
        
    private let log = Logger()
    
    @Published var availablePeers: [MCPeerID] = []
    
    @Published var hasReceivedData: Bool = false
    @Published var receivedData: GameMessage?
    
    @Published var hasReceivedInvite: Bool = false
    @Published var invitationSender: MCPeerID? = nil
    
    @Published var hasPaired: Bool = false
    @Published var invitationHandler: ((Bool, MCSession?) -> Void)?
    
    init(nickname: String) {
        let peerID = MCPeerID(displayName: nickname)
        self.myPeerID = peerID
        
        session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .none)
        serviceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: serviceType)
        serviceBrowser = MCNearbyServiceBrowser(peer: peerID, serviceType: serviceType)
        super.init()
        
        session.delegate = self
        serviceAdvertiser.delegate = self
        serviceBrowser.delegate = self
                
        serviceAdvertiser.startAdvertisingPeer()
        serviceBrowser.startBrowsingForPeers()
    }
    
    deinit {
        serviceAdvertiser.stopAdvertisingPeer()
        serviceBrowser.stopBrowsingForPeers()
    }
    
    func send(data: GameMessage) {
        if !session.connectedPeers.isEmpty {
            log.info("sendMove: \(data.type) to \(self.session.connectedPeers[0].displayName)")
            do {
                try session.send(data.encode(), toPeers: session.connectedPeers, with: .reliable)
            } catch {
                log.error("Error sending: \(String(describing: error))")
            }
        }
    }
}

extension MultipeerSession: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        log.info("peer \(peerID) didChangeState: \(state.rawValue)")
        
        switch state {
        case MCSessionState.notConnected:
            // Peer disconnected
            DispatchQueue.main.async {
                self.hasPaired = false
            }
            // Peer disconnected, start accepting invitaions again
            serviceAdvertiser.startAdvertisingPeer()
            break
        case MCSessionState.connected:
            // Peer connected
            DispatchQueue.main.async {
                self.hasPaired = true
            }
            // We are paired, stop accepting invitations
            serviceAdvertiser.stopAdvertisingPeer()
            break
        default:
            // Peer connecting or something else
            DispatchQueue.main.async {
                self.hasPaired = false
            }
            break
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let string = String(data: data, encoding: .utf8) {
            log.info("didReceive move \(string)")
            // We received a move from the opponent, tell the GameView
            DispatchQueue.main.async { [self] in
                self.hasReceivedData = true
                do {
                    try self.receivedData = GameMessage.decode(from: data)
                } catch {
                    log.error("Error receiving: \(String(describing: error))")
                }
            }
        } else {
            log.info("didReceive invalid value \(data.count) bytes")
        }
    }
    
    public func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        log.error("Receiving streams is not supported")
    }
    
    public func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        log.error("Receiving resources is not supported")
    }
    
    public func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        log.error("Receiving resources is not supported")
    }
    
    public func session(_ session: MCSession, didReceiveCertificate certificate: [Any]?, fromPeer peerID: MCPeerID, certificateHandler: @escaping (Bool) -> Void) {
        certificateHandler(true)
    }
}

extension MultipeerSession: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        log.error("ServiceAdvertiser didNotStartAdvertisingPeer: \(String(describing: error))")
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        log.info("didReceiveInvitationFromPeer \(peerID)")
        
        DispatchQueue.main.async {
            // Tell PairView to show the invitation alert
            self.hasReceivedInvite = true
            // Give PairView the peerID of the peer who invited us
            self.invitationSender = peerID
            // Give PairView the `invitationHandler` so it can accept/deny the invitation
            self.invitationHandler = invitationHandler
        }
    }
}

extension MultipeerSession: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        //TODO: Tell the user something went wrong and try again
        log.error("ServiceBroser didNotStartBrowsingForPeers: \(String(describing: error))")
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        log.info("ServiceBrowser found peer: \(peerID)")
        // Add the peer to the list of available peers
        DispatchQueue.main.async {
            self.availablePeers.append(peerID)
        }
    }
    
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        log.info("ServiceBrowser lost peer: \(peerID)")
        // Remove lost peer from list of available peers
        DispatchQueue.main.async {
            self.availablePeers.removeAll(where: {
                $0 == peerID
            })
        }
    }
}
