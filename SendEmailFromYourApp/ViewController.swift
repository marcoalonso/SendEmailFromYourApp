//
//  ViewController.swift
//  SendEmailFromYourApp
//
//  Created by marco alonso on 20/02/21.
//

import UIKit
import MessageUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        }
    
    func showMailComposer() {
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            let alert = UIAlertController(title: "Error al enviar email", message: "Necesitas iniciar sesion en la app de correo", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            present(alert, animated: true)
            return
        }
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        // Configure the fields of the interface.
        composeVC.setToRecipients(["al0ns0o.mt@gmail.com"])
        composeVC.setSubject("Hello i want more info!")
        composeVC.setMessageBody("I would like to know more about this app!", isHTML: false)
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
    
    @IBAction func sendEmailButtonPressed(_ sender: UIButton) {
        showMailComposer()
    }
}

//MARK:- delegate methods MFMailCompose
extension ViewController: MFMailComposeViewControllerDelegate {
 
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let _ = error {
            //show error alert
            controller.dismiss(animated: true)
            return
        }
        
        
        switch result {
        case .cancelled:
            print("Cancelado")
            showAlert(msj: "Cancelled")
        case .failed:
            print("Error al enviar msj")
            showAlert(msj: "Error to send msj")
        case .saved:
            print("Guardado en borradores!")
            showAlert(msj: "Saved ind drafts")
        case .sent:
            print("Correo enviado!")
            showAlert(msj: "email sent")
        default:
            print("error desconocido")
            showAlert(msj: "uknown error")
        }
        
        controller.dismiss(animated: true)
    }
    func showAlert(msj: String) {
        let alert = UIAlertController(title: "Notificacion", message: msj, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: msj, style: .default, handler: nil))
        present(alert, animated: true)
        
    }
}


