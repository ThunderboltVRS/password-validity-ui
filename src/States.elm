module States exposing (..)

import Types exposing (..)
import Material
import Ports exposing (..)
import String exposing (..)
import Regex


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
          , subRules = []
          }
        , { regEx = "(?=.*[A-Z])"
          , description = "At least one uppercase"
          , mandatory = True
          , valid = False
          , subRules = []
          }
          , { regEx = "(?=.*[a-z])"
          , description = "At least one lowercase"
          , mandatory = True
          , valid = False
          , subRules = []
          }
          , { regEx = "(?=.*[^A-Za-z0-9])"
          , description = "At least one special character"
          , mandatory = True
          , valid = False
          , subRules = [
              { regEx = String.concat ["^((?!\\s).)*$"]
                        , description = "No spaces are allowed"
                        , mandatory = True
                        , valid = True
              }
              ,
              { regEx = String.concat ["^((?!£).)*$"]
                        , description = "No pound(£) symbols are allowed"
                        , mandatory = True
                        , valid = True
              }
          ]
          }
          , { regEx = ".{8,}"
          , description = "A minimum of 8 characters"
          , mandatory = True
          , valid = False
          , subRules = []
          }
        ]
    , valid = False
    , mdl = Material.model
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Ports.alterPassword AlterPassword ]
