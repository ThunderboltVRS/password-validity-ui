module Main exposing (..)

import Html.App
import View exposing (..)
import States exposing (..)
import Update exposing (..)

main : Program Never
main =
    Html.App.program
        { init = defaultModel
        , subscriptions = subscriptions
        , update = update
        , view = View.view
        }
