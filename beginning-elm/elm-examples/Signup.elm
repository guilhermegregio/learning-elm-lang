module Main exposing (main)

import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (id, type_, css, href, src)
import Html.Styled.Events exposing (onClick)
import SignupStyle exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ styledH1 [] [ text "Sign up" ]
        , styledForm []
            [ div []
                [ text "Name"
                , inputText
                    [ id "name"
                    , type_ "text"
                    ]
                    []
                ]
            , div []
                [ text "E-mail"
                , inputText
                    [ id "email"
                    , type_ "email"
                    ]
                    []
                ]
            , div []
                [ text "Password"
                , inputText
                    [ id "password"
                    , type_ "password"
                    ]
                    []
                ]
            , div []
                [ styledButton [ type_ "submit" ]
                    [ text "Create my account" ]
                ]
            ]
        ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { view = view >> toUnstyled
        , update = update
        , model = initialModel
        }


update : Msg -> Model -> Model
update msg model =
    model


type Msg
    = DoSomething


type alias Model =
    ()


initialModel : Model
initialModel =
    ()
