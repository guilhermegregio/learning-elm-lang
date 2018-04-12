module SignupStyle exposing (..)

import Css exposing (..)
import Css.Colors exposing (..)
import Html.Styled exposing (..)


styledH1 : List (Attribute msg) -> List (Html msg) -> Html msg
styledH1 =
    styled h1
        [ paddingLeft (cm 3)
        ]


styledForm : List (Attribute msg) -> List (Html msg) -> Html msg
styledForm =
    styled form
        [ borderRadius (px 5)
        , backgroundColor (hex "f2f2f2")
        , padding (px 20)
        , width (px 300)
        ]


inputText : List (Attribute msg) -> List (Html msg) -> Html msg
inputText =
    styled input
        [ display block
        , width (px 260)
        , padding2 (px 12) (px 20)
        , margin2 (px 8) zero
        , borderStyle none
        , borderRadius (px 4)
        ]


styledButton : List (Attribute msg) -> List (Html msg) -> Html msg
styledButton =
    styled button
        [ width (px 300)
        , backgroundColor (hex "397cd5")
        , color white
        , padding2 (px 14) (px 20)
        , marginTop (px 10)
        , borderStyle none
        , borderRadius (px 4)
        , fontSize (px 16)
        ]
