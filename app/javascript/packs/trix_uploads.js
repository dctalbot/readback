import { DirectUpload } from 'activestorage'
import * as Trix from 'trix'
import 'trix/dist/trix.css'

Trix.config.attachments.preview.caption = {
  name: false,
  size: false,
}

const uploadAttachment = attachment => {
  const file = attachment.file
  let upload = new DirectUpload(file, '/rails/active_storage/direct_uploads')

  upload.create((error, blob) => {
    if (error) {
      console.log('Error uploading file from Trix')
    } else {
      // Add an appropriately-named hidden input to the form with a
      //  value of blob.signed_id so that the blob ids will be
      //  transmitted in the normal upload flow
      const hiddenField = document.createElement('input')
      hiddenField.setAttribute('type', 'hidden')
      hiddenField.name = 'dj[images][]'
      hiddenField.setAttribute('value', blob.signed_id)
      document.querySelector('form').appendChild(hiddenField)

      return attachment.setAttributes({
        url:
          '/rails/active_storage/blobs/' +
          blob.signed_id +
          '/' +
          encodeURIComponent(blob.filename),
      })
    }
  })
}

// Listen for the Trix attachment event to trigger upload
// If Trix editor has prevent-uploads data attribute, disallow upload
addEventListener('trix-attachment-add', event => {
  if (event.target.dataset.trixPreventUploads) {
    return event.preventDefault()
  }
  const attachment = event.attachment
  if (attachment.file) {
    return uploadAttachment(attachment)
  }
})
