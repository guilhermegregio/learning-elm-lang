module Main exposing (main)

import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (id, type_, css, href, src)
import Html.Styled.Events exposing (onClick, onInput)
import SignupStyle exposing (..)


view : User -> Html Msg
view user =
    div []
        [ styledH1 [] [ text "Sign up" ]
        , styledForm []
            [ div []
                [ text "Name"
                , inputText
                    [ id "name"
                    , type_ "text"
                    , onInput SaveName
                    ]
                    []
                ]
            , div []
                [ text "E-mail"
                , inputText
                    [ id "email"
                    , type_ "email"
                    , onInput SaveEmail
                    ]
                    []
                ]
            , div []
                [ text "Password"
                , inputText
                    [ id "password"
                    , type_ "password"
                    , onInput SavePassword
                    ]
                    []
                ]
            , div []
                [ styledButton
                    [ type_ "submit"
                    , onClick Signup
                    ]
                    [ text "Create my account" ]
                ]
            ]
        , code [] [ text (toString user) ]
        ]


main : Program Never User Msg
main =
    Html.beginnerProgram
        { view = view >> toUnstyled
        , update = update
        , model = initialModel
        }


type alias User =
    { name : String
    , email : String
    , password : String
    , loggedIn : Bool
    }


type Msg
    = SaveName String
    | SaveEmail String
    | SavePassword String
    | Signup


update : Msg -> User -> User
update message user =
    case message of
        SaveName name ->
            { user | name = name }

        SaveEmail email ->
            { user | email = email }

        SavePassword password ->
            { user | password = password }

        Signup ->
            { user | loggedIn = True }


initialModel : User
initialModel =
    { name = ""
    , email = ""
    , password = ""
    , loggedIn = False
    }
