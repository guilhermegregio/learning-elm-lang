module Main exposing (..)

import Html exposing (text)
import Json.Decode exposing (..)


main =
    json
        |> decodeString userDecoder
        |> toString
        |> text


type alias User =
    { id : Int
    , email : String
    , isPremium : Bool
    }


json =
    """
{
  "id" : 123,
  "email" : "joe@domain.net",
  "isPremium" : true
}
"""


userDecoder =
    map3
        User
        (field "id" int)
        (field "email" string)
        (field "isPremium" bool)
