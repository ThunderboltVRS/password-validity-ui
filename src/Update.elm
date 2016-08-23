module Update exposing (..)

import Types exposing (..)
import Material
import Regex


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Types.Mdl msg' ->
            Material.update msg' model

        AlterPassword newPassword ->
            ( recalculateRules newPassword model
                |> updateModelValidity
            , Cmd.none
            )


updateModelValidity : Model -> Model
updateModelValidity model =
    { model | valid = List.all (\r -> r.valid) model.rules }


recalculateRules : String -> Model -> Model
recalculateRules newPassword model =
    { model | rules = List.map (\r -> recalculateRule newPassword r) model.rules }


recalculateRule : String -> PasswordRule -> PasswordRule
recalculateRule password passwordRule =
    { passwordRule | valid = (Regex.contains (Regex.regex passwordRule.regEx)  password) }
