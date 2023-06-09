//___FILEHEADER___

import SwiftUI
import Photos
import PhotosUI

class ___FILEBASENAME___: UIViewController, PHContentEditingController {

    var input: PHContentEditingInput?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        let contentView: ContentView = .init()

        let contentViewHostingController: UIHostingController<ContentView> = .init(rootView: contentView)

        self.addChild(contentViewHostingController)
        self.view.addSubview(contentViewHostingController.view)

        contentViewHostingController.didMove(toParent: self)

        contentViewHostingController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentViewHostingController.view.heightAnchor.constraint(equalTo: self.view.heightAnchor),
            contentViewHostingController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            contentViewHostingController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            contentViewHostingController.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }

    // MARK: - PHContentEditingController

    func canHandle(_ adjustmentData: PHAdjustmentData) -> Bool {
        // Inspect the adjustmentData to determine whether your extension can work with past edits.
        // (Typically, you use its formatIdentifier and formatVersion properties to do this.)
        return false
    }

    func startContentEditing(with contentEditingInput: PHContentEditingInput, placeholderImage: UIImage) {
        // Present content for editing, and keep the contentEditingInput for use when closing the edit session.
        // If you returned true from canHandleAdjustmentData:, contentEditingInput has the original image and adjustment data.
        // If you returned false, the contentEditingInput has past edits "baked in".
        input = contentEditingInput
    }

    func finishContentEditing() async -> PHContentEditingOutput? {
        // Update UI to reflect that editing has finished and output is being rendered.

        // Create editing output from the editing input.
        let output = PHContentEditingOutput(contentEditingInput: self.input!)

        // Provide new adjustments and render output to given location.
        // output.adjustmentData = <#new adjustment data#>
        // let renderedJPEGData = <#output JPEG#>
        // renderedJPEGData.writeToURL(output.renderedContentURL, atomically: true)

        // Clean up temporary files, etc.

        return output
    }

    var shouldShowCancelConfirmation: Bool {
        // Determines whether a confirmation to discard changes should be shown to the user on cancel.
        // (Typically, this should be "true" if there are any unsaved changes.)
        return false
    }

    func cancelContentEditing() {
        // Clean up temporary files, etc.
        // May be called after finishContentEditingWithCompletionHandler: while you prepare output.
    }

}
