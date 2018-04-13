module Main exposing (..)

import Html exposing (text)
import Json.Decode exposing (..)
import Json.Decode.Extra exposing (date, parseInt, fromResult)
import Date exposing (Date)


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
    , gender : Maybe Gender
    , dateOfBirth : Date
    , notifications : List Notification
    }


type alias Notification =
    { title : String
    , message : String
    }


json =
    """
{
  "id" : "123",
  "email" : "Joe@domain.net",
  "isPremium" : true,
  "profile" : {
    "gender": "male",
    "dateOfBirth": "Sun Jan 07 2018 00:18:17 GMT+0100 (CET)"
  },
  "notifications" : [
    { "title" : "Welcome back!", "message" : "We've been missing you" },
    { "title" : "Weather alert", "message" : "Expect stormy weather" }
  ]
}
"""


userDecoder =
    map6 User
        (field "id" parseInt)
        (field "email" (string |> map String.toLower))
        (field "isPremium" membership)
        (maybe (at [ "profile", "gender" ] gender))
        (at [ "profile", "dateOfBirth" ] date)
        (field "notifications" (list notification))


notification =
    map2 Notification
        (field "title" string)
        (field "message" string)


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
