module States exposing (..)

import Types exposing (..)
import Ports exposing (..)
import String exposing (..)


defaultModel : ( Model, Cmd Msg )
defaultModel =
    ( initialModel, Cmd.none )


initialModel : Model
initialModel =
    { passwordText = ""
    , rules =
        [ { regEx = ".{8,}"
          , description = "A minimum of 8 characters"
          , mandatory = True
          , validity = No
          , subRules = []
          }
        , { regEx = "(?=.*\\d)"
          , description = "At least 1 number"
          , mandatory = True
          , validity = No
          , subRules = []
          }
        , { regEx = "(?=.*[A-Z])"
          , description = "At least 1 uppercase letter"
          , mandatory = True
          , validity = No
          , subRules = []
          }
        , { regEx = "(?=.*[a-z])"
          , description = "At least 1 lowercase letter"
          , mandatory = True
          , validity = No
          , subRules = []
          }
        , { regEx = "(?=.*[^A-Za-z0-9])"
          , description = "At least 1 special character"
          , mandatory = True
          , validity = No
          , subRules =
                [ { regEx = String.concat [ "^((?!\\s).)*$" ]
                  , description = "No spaces allowed"
                  , mandatory = True
                  , validity = Yes
                  }
                , { regEx = String.concat [ "^((?!£).)*$" ]
                  , description = "No pound(£) symbols allowed"
                  , mandatory = True
                  , validity = Yes
                  }
                ]
          }
        ]
    , validity = No
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Ports.alterPassword AlterPassword ]
