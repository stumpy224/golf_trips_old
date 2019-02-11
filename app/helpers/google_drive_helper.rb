require 'google/apis/drive_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'
require 'json'

module GoogleDriveHelper
  DRIVE_LOCATION = "vendor/drive/"
  CREDENTIALS_PATH = DRIVE_LOCATION + "credentials.json".freeze
  CREDENTIALS_JSON = JSON.parse(File.read(CREDENTIALS_PATH)).freeze
  OOB_URI = CREDENTIALS_JSON["installed"]["oob_uri"].freeze
  REFRESH_TOKEN = CREDENTIALS_JSON["installed"]["refresh_token"].freeze
  SCOPE = Google::Apis::DriveV3::AUTH_DRIVE_READONLY
  TOKEN_PATH = DRIVE_LOCATION + "token.yaml".freeze

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

    client_id = Google::Auth::ClientId.from_file(CREDENTIALS_PATH)
    token_store = Google::Auth::Stores::FileTokenStore.new(file: TOKEN_PATH)
    authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
    user_id = 'default'
    credentials = authorizer.get_credentials(user_id)

    if credentials.nil?
      puts "credentials are nil"
      credentials = authorizer.get_and_store_credentials_from_code(
          user_id: user_id, code: REFRESH_TOKEN, base_url: OOB_URI
      )
    end

    drive_service.authorization = credentials
    drive_service
  end
end
