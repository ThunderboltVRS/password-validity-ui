module States exposing (..)

import Types exposing (..)
import Material
import Ports exposing (..)


defaultModel : ( Model, Cmd Msg )
defaultModel =
    ( initialModel, Cmd.none )


initialModel : Model
initialModel =
    { passwordText = ""
    , rules =
        [ { regEx = "(?=.*\\d)"
          , description = "At least one number"
          , mandatory = True
          , valid = False
          }
        , { regEx = "(?=.*[A-Z])"
          , description = "At least one uppercase"
          , mandatory = True
          , valid = False
          }
          , { regEx = "(?=.*[a-z])"
          , description = "At least one lowercase"
          , mandatory = True
          , valid = False
          }
          , { regEx = "(?=.*[^A-Za-z0-9])"
          , description = "At least one special character"
          , mandatory = True
          , valid = False
          }
          , { regEx = ".{8,}"
          , description = "A minimum of 8 characters"
          , mandatory = True
          , valid = False
          }
        ]
    , valid = False
    , mdl = Material.model
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Ports.alterPassword AlterPassword ]
