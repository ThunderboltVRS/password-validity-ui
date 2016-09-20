module Types exposing (..)

import Material


type Msg
    = Mdl (Material.Msg Msg)
    | AlterPassword String


type alias PasswordRule =
    { regEx : String
    , description : String
    , mandatory : Bool
    , valid : Bool
    , subRules : List SubRule
    }


type alias SubRule =
    { regEx : String
    , description : String
    , mandatory : Bool
    , valid : Bool
    }


type alias Model =
    { passwordText : String
    , rules : List PasswordRule
    , valid : Bool
    , mdl : Material.Model
    }
