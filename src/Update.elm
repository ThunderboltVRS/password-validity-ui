module Update exposing (..)

import Types exposing (..)
import Regex


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AlterPassword newPassword ->
            ( recalculateRules newPassword model
                |> updateModelValidity
            , Cmd.none
            )


updateModelValidity : Model -> Model
updateModelValidity model =
    let allValid = List.all (\r -> r.validity == Yes) model.rules
    in
    { model | valid = if allValid then Yes else No }


recalculateRules : String -> Model -> Model
recalculateRules newPassword model =
    { model | rules = List.map (\r -> recalculateRule newPassword r) model.rules }


recalculateRule : String -> PasswordRule -> PasswordRule
recalculateRule password passwordRule =
    let
        subRulesCalculated =
            recalculateSubRules password passwordRule
    in
        { subRulesCalculated | valid = passwordRuleValidity password subRulesCalculated }


passwordRuleValidity : String -> PasswordRule -> Validity
passwordRuleValidity password passwordRule =
    let rulePasswordValid = Regex.contains (Regex.regex passwordRule.regEx) password
        subRuleEmpty = List.isEmpty passwordRule.subRules
    in 
        if (not rulePasswordValid) then
            No
        else if (List.isEmpty passwordRule.subRules || List.all (\r -> r.validity == Yes) passwordRule.subRules) then
            Yes
        else
            Partial


recalculateSubRules : String -> PasswordRule -> PasswordRule
recalculateSubRules password passwordRule =
    { passwordRule | subRules = List.map (\r -> recalculateSubRule password r) passwordRule.subRules }


recalculateSubRule : String -> SubRule -> SubRule
recalculateSubRule password passwordRule =
    { passwordRule | valid = 
        case (Regex.contains (Regex.regex passwordRule.regEx) password) of
            True -> Yes
            False -> No
          }
