module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode
import Data.Forecast exposing (..)
import Request.Forecast


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { forecast : Maybe Forecast
    , place : String
    , loading : Bool
    , errorInGetInformation : Bool
    }


init : ( Model, Cmd Msg )
init =
    Model Nothing "" False False ! []



-- UPDATE


type Msg
    = InputPlace String
    | ForecastResponse (Result Http.Error Forecast)
    | GetForecast


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ForecastResponse (Ok forecast) ->
            { model | forecast = Just forecast, loading = True, errorInGetInformation = False } ! []

        ForecastResponse (Err error) ->
            { model | errorInGetInformation = True, forecast = Nothing, loading = False } ! []

        InputPlace place ->
            { model | place = place } ! []

        GetForecast ->
            { model | loading = True, errorInGetInformation = False }
                ! [ Request.Forecast.getForecast model.place
                        |> Http.send ForecastResponse
                  ]



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input [ onInput InputPlace, value model.place, placeholder "Enter name of city" ] []
        , button [ onClick GetForecast ] [ text "Search" ]
        , if model.errorInGetInformation then
            p [] [ text "Error in get information" ]
          else
            div [] []
        , case model.forecast of
            Nothing ->
                if model.loading then
                    p [] [ text "Loading..." ]
                else
                    div [] []

            Just forecast ->
                pre [ style [ ( "white-space", "pre-wrap" ), ( "word-wrap", "break-word" ) ] ] [ toString forecast |> text ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
