module Main exposing (..)

import Html exposing (text)
import Json.Decode exposing (..)
import Json.Decode.Extra exposing (parseInt)


main =
    json
        |> decodeString userDecoder2
        |> toString
        |> text


type Membership
    = Standard
    | Premium


type Gender
    = Female
    | Male


type alias User =
    { id : Int
    , email : String
    , membership : Membership
    , gender : Gender
    }


json =
    """
{
  "id" : "123",
  "email" : "Joe@domain.net",
  "isPremium" : true,
  "gender": "male"
}
"""


userDecoder2 =
    map2 (\a b -> a ++ " " ++ b)
        (field "id" string)
        (field "email" string)


userDecoder =
    map4 User
        (field "id" parseInt)
        (field "email" (string |> map String.toLower))
        (field "isPremium" membership)
        (field "gender" gender)


gender =
    let
        toGender s =
            case s of
                "male" ->
                    succeed Male

                "female" ->
                    succeed Female

                _ ->
                    fail (s ++ " is not a valid gender")
    in
        string |> andThen toGender


membership =
    let
        toMembership b =
            case b of
                True ->
                    Premium

                False ->
                    Standard
    in
        bool |> map toMembership