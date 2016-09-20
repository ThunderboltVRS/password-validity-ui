module View exposing (..)

import Html exposing (..)
import Types exposing (..)
import Material.Icon
import Material
import Material.Options
import Html exposing (..)
import Types exposing (..)


validColor : String
validColor =
    "#00b300"


invalidColor : String
invalidColor =
    "#e60000"


view : Model -> Html Msg
view model =
    layoutTable model


layoutTable : Model -> Html Types.Msg
layoutTable model =
    table
        []
        (rulesDisplay model)


rulesDisplay : Model -> List (Html Types.Msg)
rulesDisplay model =
    List.append (List.map (\e -> ruleRow model.mdl e) model.rules) [ allRuleRow model.mdl model ]


allRuleRow : Material.Model -> Model -> Html Types.Msg
allRuleRow mdl model =
    tr
        []
        [ td [] [ ruleIcon mdl model.valid ]
        , td [] [ ruleText "All Rules" ]
        ]


ruleIcon : Material.Model -> Bool -> Html Types.Msg
ruleIcon mdl valid =
    if valid then
        Material.Icon.view "check_box" [ Material.Options.css "color" validColor ]
    else
        Material.Icon.view "indeterminate_check_box" [ Material.Options.css "color" invalidColor ]


ruleRow : Material.Model -> PasswordRule -> Html Types.Msg
ruleRow mdl passwordRule =
    tr
        []
        (List.append [ td [] [ ruleIcon mdl passwordRule.valid ] ] ([ ruleCell passwordRule ]))


ruleCell : PasswordRule -> Html Types.Msg
ruleCell passwordRule =
    td []
        (List.append [ div [] [ ruleText passwordRule.description ] ] (subRules passwordRule))


subRules : PasswordRule -> List (Html Types.Msg)
subRules passwordRule =
    (List.filter (\s -> not s.valid) passwordRule.subRules |> List.map (\s -> subRule s))


subRule : SubRule -> Html Types.Msg
subRule subRule =
    div [] [ subRuleText subRule.description ]


ruleText : String -> Html Types.Msg
ruleText description =
    text description


subRuleText : String -> Html Types.Msg
subRuleText description =
    text description
