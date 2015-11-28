module Spotify
  module API

    #
    # TODO: This should become a model.
    #
    module Errors

      TIMEOUT       = { 'status' => 700, 'message' => "Timed out"                                          }
      UNEXPECTED    = { 'status' => 710, 'message' => "Unexpected error"                                   }
      MAX_RETRIES   = { 'status' => 720, 'message' => "Max retries"                                        }
      NOT_AVAILABLE = { 'status' => 730, 'message' => "This feature is not available yet"                  }
      PARSER_ERROR  = { 'status' => 740, 'message' => "Something went wrong. Please verify the parameters" }

    end

  end
end
