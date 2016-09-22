module Types exposing (..)

type Msg
    = AlterPassword String


type Validity
    = Yes
    | Partial
    | No


type alias PasswordRule =
    { regEx : String
    , description : String
    , mandatory : Bool
    , validity : Validity
    , subRules : List SubRule
    }


type alias SubRule =
    { regEx : String
    , description : String
    , mandatory : Bool
    , validity : Validity
    }


type alias Model =
    { passwordText : String
    , rules : List PasswordRule
    , validity : Validity
    }
