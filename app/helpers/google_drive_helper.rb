require 'google/apis/drive_v3'
require 'googleauth'

module GoogleDriveHelper
  MIME_TYPE_FOLDER = "application/vnd.google-apps.folder"
  MIME_TYPE_GOOGLE_DOC = "application/vnd.google-apps.document"

  def get_outing_docs(outing_name)
    # Retrieve everything from Google Drive, includes folders and files
    drive_files = google_drive_service.list_files(fields: 'files(id, name, mime_type, parents, modified_time, web_view_link, export_links)').files

    # Determine id for outing folder, and then find files associated to folder to return
    outing_folder_id = get_outing_folder_id(outing_name, drive_files)

    return get_outing_files(outing_folder_id, drive_files)
  end

  private

  def get_outing_folder_id(outing_name, drive_files)
    drive_files.each do |drive_file|
      return drive_file.id if drive_file.name == outing_name && drive_file.mime_type == MIME_TYPE_FOLDER
    end
  end

  def get_outing_files(outing_folder_id, drive_files)
    outing_files = []

    drive_files.each do |drive_file|
      if drive_file.mime_type == MIME_TYPE_GOOGLE_DOC && drive_file.parents.include?(outing_folder_id)
        outing_files.push(drive_file)
      end
    end

    return outing_files
  end

  ##
  # Ensure valid credentials, either by restoring from the saved credentials
  # files or initiating an OAuth2 authorization. If authorization is required,
  # the user's default browser will be launched to approve the request.
  #
  # @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
  def google_drive_service
    drive_service = Google::Apis::DriveV3::DriveService.new

    # source: https://www.rubydoc.info/github/gimite/google-drive-ruby/GoogleDrive
    credentials = Google::Auth::UserRefreshCredentials.new(
        client_id: Rails.application.credentials.google_drive[:client_id],
        client_secret: Rails.application.credentials.google_drive[:client_secret],
        scope: [Google::Apis::DriveV3::AUTH_DRIVE_READONLY],
        redirect_uri: "urn:ietf:wg:oauth:2.0:oob")
    credentials.refresh_token = Rails.application.credentials.google_drive[:refresh_token]
    credentials.fetch_access_token!
    GoogleDrive.login_with_oauth(credentials.access_token)

    drive_service.authorization = credentials
    drive_service
  end
end
