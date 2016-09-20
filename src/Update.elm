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
    let
        subRulesCalculated =
            recalculateSubRules password passwordRule
    in
        { subRulesCalculated | valid = passwordRuleValid password subRulesCalculated }


passwordRuleValid : String -> PasswordRule -> Bool
passwordRuleValid password passwordRule =
    (Regex.contains (Regex.regex passwordRule.regEx) password) && (List.isEmpty passwordRule.subRules || List.all (\r -> r.valid) passwordRule.subRules)


recalculateSubRules : String -> PasswordRule -> PasswordRule
recalculateSubRules password passwordRule =
    { passwordRule | subRules = List.map (\r -> recalculateSubRule password r) passwordRule.subRules }


recalculateSubRule : String -> SubRule -> SubRule
recalculateSubRule password passwordRule =
    { passwordRule | valid = (Regex.contains (Regex.regex passwordRule.regEx) password) }


calculateRegex =
    (Regex.contains (Regex.regex ("(?!.*[£])")) "gf£")
