module Main exposing (..)

import Html exposing (..)
import Keyboard
import Mouse


type alias Model =
    Int


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ text (toString model) ]


type Msg
    = KeyPressed Keyboard.KeyCode
    | MouseClicked Mouse.Position


type alias KeyCode =
    Int


type alias Position =
    { x : Int
    , y : Int
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        KeyPressed _ ->
            ( model + 1, Cmd.none )

        MouseClicked position ->
            ( model - 1, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Keyboard.presses KeyPressed
        , Mouse.clicks MouseClicked
        ]


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
