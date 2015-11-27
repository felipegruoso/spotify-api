module Spotify
  module API
    module Errors

      TIMEOUT       = { status: 700, message: "Timed out"                         }
      UNEXPECTED    = { status: 710, message: "Unexpected error"                  }
      MAX_RETRIES   = { status: 720, message: "Max retries"                       }
      NOT_AVAILABLE = { status: 730, message: "This feature is not available yet" }

    end
  end
end
