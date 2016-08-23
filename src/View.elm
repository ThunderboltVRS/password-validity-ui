module View exposing (..)

import Html exposing (..)
import Types exposing (..)
import Material.Scheme
import Material.Grid
import Material.Color
import Material.Elevation
import Material.Options exposing (Style, css)
import Material.Grid exposing (..)
import Material.Grid
import Material.Options exposing (Style, css, cs)
import Material.Grid exposing (..)
import Material.Icon
import Html exposing (..)
import Types exposing (..)
import Material.Elevation as Elevation
import Material
import Material.List as Lists

validColor : String
validColor = "#65E62D"

invalidColor : String
invalidColor = "#F22727"


view : Model -> Html Msg
view model =
    layoutGrid model
        |> Material.Scheme.topWithScheme Material.Color.Blue Material.Color.LightBlue


layoutGrid : Model -> Html Types.Msg
layoutGrid model =
    Material.Grid.grid
        []
        [ cell 100 [ size All 4, size Tablet 4, Material.Elevation.e16 ] [ rulesDisplay model ]
        ]


cellStyle : Int -> List (Style a)
cellStyle h =
    [ css "text-sizing" "border-box"
    , css "height" (toString h ++ "%")
    , css "padding-left" "0px"
    , css "padding-top" "0px"
    ]


cell : Int -> List (Style a) -> List (Html a) -> Material.Grid.Cell a
cell height styling =
    Material.Grid.cell <| List.concat [ cellStyle height, styling ]


ruleIcon : Material.Model -> PasswordRule -> Html Types.Msg
ruleIcon mdl passwordRule =
    if passwordRule.valid then
        Material.Icon.view "check_box" [ Material.Options.css "color" validColor ]
    else
        Material.Icon.view "indeterminate_check_box" [ Material.Options.css "color" invalidColor ]

allRulesIcon : Material.Model -> Model -> Html Types.Msg
allRulesIcon mdl model =
    if model.valid then
        Material.Icon.view "check_box" [ Material.Options.css "color" validColor ]
    else
        Material.Icon.view "indeterminate_check_box" [ Material.Options.css "color" invalidColor ]


ruleGrid : Material.Model -> PasswordRule -> Html Types.Msg
ruleGrid mdl passwordRule =
    Lists.li
        []
        [ Lists.content [Material.Options.css "align" "left"] [ ruleIcon mdl passwordRule ]
        , Lists.content [] [ text passwordRule.description ]
        ]

allRulesDisplay : Material.Model -> Model -> Html Types.Msg
allRulesDisplay mdl model =
    Lists.li
        []
        [ Lists.content [] [ allRulesIcon mdl model ]
        , Lists.content [] [ text "All Rules" ]
        ]


rulesDisplay : Model -> Html Types.Msg
rulesDisplay model =
    Lists.ul 
        [] 
        (List.append (List.map (\e -> ruleGrid model.mdl e) model.rules) [ allRulesDisplay model.mdl model])
