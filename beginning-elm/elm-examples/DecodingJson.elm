module DecodingJson exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Http
import Json.Decode exposing (string, int, list, field, map3, decodeString, Decoder)
import Json.Decode.Pipeline exposing (decode, required, optional, requiredAt, optionalAt)


type alias Post =
    { id : Int
    , title : String
    , author : String
    }


type alias Model =
    { posts : List Post
    , errorMessage : Maybe String
    , loading : Bool
    }


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick SendHttpRequest ]
            [ text "Get data from server" ]
        , code [] [ text (toString model.loading) ]
        , viewPostsOrError model
        ]


viewPostsOrError : Model -> Html Msg
viewPostsOrError model =
    case model.errorMessage of
        Just message ->
            viewError message

        Nothing ->
            viewPosts model.posts


viewError : String -> Html Msg
viewError errorMessage =
    let
        errorHeading =
            "Couldn't fetch data at this time."
    in
        div []
            [ h3 [] [ text errorHeading ]
            , text ("Error: " ++ errorMessage)
            ]


viewPosts : List Post -> Html Msg
viewPosts posts =
    div []
        [ h3 [] [ text "Posts" ]
        , table []
            ([ viewTableHeader ] ++ List.map viewPost posts)
        ]


viewTableHeader : Html Msg
viewTableHeader =
    tr []
        [ th []
            [ text "ID" ]
        , th []
            [ text "Title" ]
        , th []
            [ text "Author" ]
        ]


viewPost : Post -> Html Msg
viewPost post =
    tr []
        [ td []
            [ text (toString post.id) ]
        , td []
            [ text post.title ]
        , td []
            [ text post.author ]
        ]


type Msg
    = SendHttpRequest
    | DataReceived (Result Http.Error (List Post))


postDecoder : Decoder Post
postDecoder =
    decode Post
        |> required "id" int
        |> required "title" string
        |> optional "author" string "anonymous"


httpCommand : Cmd Msg
httpCommand =
    list postDecoder
        |> Http.get "http://localhost:5019/posts"
        |> Http.send DataReceived


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SendHttpRequest ->
            ( { model
                | loading = True
              }
            , httpCommand
            )

        DataReceived (Ok posts) ->
            ( { model
                | posts = posts
                , errorMessage = Nothing
                , loading = False
              }
            , Cmd.none
            )

        DataReceived (Err httpError) ->
            ( { model
                | errorMessage = Just (createErrorMessage httpError)
              }
            , Cmd.none
            )


createErrorMessage : Http.Error -> String
createErrorMessage httpError =
    case httpError of
        Http.BadUrl message ->
            message

        Http.Timeout ->
            "Server is taking too long to respond. Please try again later."

        Http.NetworkError ->
            "It appears you don't have an Internet connection right now."

        Http.BadStatus response ->
            response.status.message

        Http.BadPayload message response ->
            message


init : ( Model, Cmd Msg )
init =
    ( { posts = []
      , errorMessage = Nothing
      , loading = False
      }
    , Cmd.none
    )


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
