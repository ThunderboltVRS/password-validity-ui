module View exposing (..)

import Html exposing (..)
import Types exposing (..)
import Html.Attributes exposing (..)
import String


validPath : String
validPath =
    "../UI/Image/md_check_box_green_24dp_1x.png"


invalidPath : String
invalidPath =
    "../UI/Image/md_indeterminate_check_box_red_24dp_1x.png"


partialPath : String
partialPath =
    "../UI/Image/md_indeterminate_check_box_orange_24dp_1x.png"


validColor : String
validColor =
    "#00b300"


partialColor : String
partialColor =
    "#ff8000"


invalidColor : String
invalidColor =
    "black"


mainTableWidth : Int
mainTableWidth =
    100


iconCellWidth : Int
iconCellWidth =
    40


iconHeight : Int
iconHeight =
    20


ruleTextSize : Int
ruleTextSize =
    11


subRuleTextSize : Int
subRuleTextSize =
    10


minRowHeight : Int
minRowHeight =
    25


view : Model -> Html Msg
view model =
    layoutTable model


layoutTable : Model -> Html Types.Msg
layoutTable model =
    table
        [ Html.Attributes.style
            [ ( "width", percentUnit mainTableWidth )
            ]
        ]
        (rulesDisplay model)


rulesDisplay : Model -> List (Html Types.Msg)
rulesDisplay model =
    List.append (List.map (\e -> ruleRow e) model.rules) []


ruleIcon : Validity -> Html Types.Msg
ruleIcon validity =
    img
        [ Html.Attributes.src (validityIcon validity)
        , Html.Attributes.style
            [ ( "height", pixelUnit iconHeight )
            ]
        ]
        []


validityIcon : Validity -> String
validityIcon validity =
    case validity of
        Yes ->
            validPath

        No ->
            invalidPath

        Partial ->
            partialPath


validityColor : Validity -> String
validityColor validity =
    case validity of
        Yes ->
            validColor

        No ->
            invalidColor

        Partial ->
            partialColor


ruleRow : PasswordRule -> Html Types.Msg
ruleRow passwordRule =
    tr
        [ Html.Attributes.style ruleRowStyle ]
        (List.append
            [ td
                [ Html.Attributes.style
                    [ ( "width", pixelUnit iconCellWidth )
                    , ( "vertical-align", "initial" )
                    ]
                ]
                [ div [ Html.Attributes.style [ ( "min-height", pixelUnit minRowHeight ) ] ] [ ruleIcon passwordRule.validity ] ]
            ]
            ([ ruleCell passwordRule ])
        )


ruleCell : PasswordRule -> Html Types.Msg
ruleCell passwordRule =
    td
        [ Html.Attributes.style [ ( "vertical-align", "top" ) ]
        ]
        (List.append
            [ div
                [ Html.Attributes.style
                    (List.append ([ ( "color", validityColor passwordRule.validity ) ]) (textStyle ruleTextSize))
                ]
                [ ruleText passwordRule.description ]
            ]
            (subRules passwordRule)
        )


subRules : PasswordRule -> List (Html Types.Msg)
subRules passwordRule =
    (List.filter (\s -> s.validity == No) passwordRule.subRules |> List.map (\s -> subRule s))


subRule : SubRule -> Html Types.Msg
subRule subRule =
    div
        [ Html.Attributes.style
            (List.append ([ ( "padding", "2px 2px 2px 15px" ), ( "color", partialColor ) ]) (textStyle subRuleTextSize))
        ]
        [ subRuleText subRule.description ]


ruleText : String -> Html Types.Msg
ruleText description =
    text description


subRuleText : String -> Html Types.Msg
subRuleText description =
    text (String.concat [ "- ", description ])


textStyle : Int -> List ( String, String )
textStyle fontSize =
    [ ( "opacity", "0.9" )
    , ( "font-size", pointUnit fontSize )
    , ( "vertical-align", "top" )
    , ( "font-family", "Segoe UI" )
    ]


ruleRowStyle : List ( String, String )
ruleRowStyle =
    [ ( "width", "100%" )
    ]


pixelUnit : Int -> String
pixelUnit value =
    (toString value) ++ "px"

percentUnit : Int -> String
percentUnit value =
    (toString value) ++ "%"

pointUnit : Int -> String
pointUnit value =
    (toString value) ++ "pt"
