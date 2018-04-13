module Main exposing (..)

import Html exposing (text)
import Json.Decode exposing (..)


main =
    json
        |> decodeString userDecoder
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
  "id" : 123,
  "email" : "Joe@domain.net",
  "isPremium" : true,
  "gender" : "male"
}
"""


userDecoder =
    map4
        User
        (field "id" int)
        (field "email" (string |> map String.toLower))
        (field "isPremium" membership)
        (field "gender" gender)


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


gender =
    let
        toGender s =
            case s of
                "female" ->
                    succeed Female

                "male" ->
                    succeed Male

                _ ->
                    fail (s ++ " is not a valid gender")
    in
        string |> andThen toGender
