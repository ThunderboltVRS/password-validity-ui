module View exposing (..)

import Html exposing (..)
import Types exposing (..)
import Material.Icon
import Material
import Material.Options
import Html exposing (..)
import Types exposing (..)
import Html.Attributes exposing (..)
import String


validColor : String
validColor =
    "#00b300"


invalidColor : String
invalidColor =
    "#e60000"


mainTableWidth : String
mainTableWidth =
    "400px"


iconCellWidth : String
iconCellWidth =
    "40px"


ruleWidth : String
ruleWidth =
    "360px"


subRuleWidth : String
subRuleWidth =
    "300px"


view : Model -> Html Msg
view model =
    layoutTable model


layoutTable : Model -> Html Types.Msg
layoutTable model =
    table
        [ Html.Attributes.style
            [ ( "width", mainTableWidth )
            ]
        ]
        (rulesDisplay model)


rulesDisplay : Model -> List (Html Types.Msg)
rulesDisplay model =
    List.append (List.map (\e -> ruleRow model.mdl e) model.rules) [ allRuleRow model.mdl model ]


allRuleRow : Material.Model -> Model -> Html Types.Msg
allRuleRow mdl model =
    tr
        [ Html.Attributes.style [ ( "width", "100%" ) ] ]
        [ td
            [ Html.Attributes.style
                [ ( "width", iconCellWidth )
                , ( "vertical-align", "initial" )
                ]
            ]
            [ ruleIcon mdl model.valid ]
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
        [ Html.Attributes.style [ ( "width", "100%" ) ] ]
        (List.append
            [ td
                [ Html.Attributes.style
                    [ ( "width", iconCellWidth )
                    , ( "vertical-align", "initial" )
                    ]
                ]
                [ ruleIcon mdl passwordRule.valid ]
            ]
            ([ ruleCell passwordRule ])
        )


ruleCell : PasswordRule -> Html Types.Msg
ruleCell passwordRule =
    td []
        (List.append
            [ div
                [ Html.Attributes.style
                    [ ( "width", ruleWidth )
                    ]
                ]
                [ ruleText passwordRule.description ]
            ]
            (subRules passwordRule)
        )


subRules : PasswordRule -> List (Html Types.Msg)
subRules passwordRule =
    (List.filter (\s -> not s.valid) passwordRule.subRules |> List.map (\s -> subRule s))


subRule : SubRule -> Html Types.Msg
subRule subRule =
    div
        [ Html.Attributes.style
            [ ( "padding-left", "20px" )
            , ( "width", subRuleWidth )
            ]
        ]
        [ subRuleText subRule.description ]


ruleText : String -> Html Types.Msg
ruleText description =
    text description


subRuleText : String -> Html Types.Msg
subRuleText description =
    text (String.concat [ "- ", description ])
