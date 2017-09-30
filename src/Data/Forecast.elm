module Data.Forecast exposing (..)

import Json.Decode exposing (int, string, float, Decoder, list)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)


type alias Query =
    { count : Int
    , created : String
    , lang : String
    }


queryDecoder : Decoder Query
queryDecoder =
    decode Query
        |> required "count" int
        |> required "created" string
        |> required "lang" string


type alias Channel =
    { astronomy : Astronomy
    , atmosphere : Atmosphere
    , description : String
    , image : Image
    , item : Item
    , language : String
    , lastBuildDate : String
    , link : String
    , location : Location
    , title : String
    , ttl : String
    , units : Units
    , wind : Wind
    }


channelDecoder : Decoder Channel
channelDecoder =
    decode Channel
        |> required "astronomy" astronomyDecoder
        |> required "atmosphere" atmosphereDecoder
        |> required "description" string
        |> required "image" imageDecoder
        |> required "item" itemDecoder
        |> required "language" string
        |> required "lastBuildDate" string
        |> required "link" string
        |> required "location" locationDecoder
        |> required "title" string
        |> required "ttl" string
        |> required "units" unitsDecoder
        |> required "wind" windDecoder


type alias Astronomy =
    { sunrise : String
    , sunset : String
    }


astronomyDecoder : Decoder Astronomy
astronomyDecoder =
    decode Astronomy
        |> required "sunrise" string
        |> required "sunset" string


type alias Atmosphere =
    { humidity : String
    , pressure : String
    , rising : String
    , visibility : String
    }


atmosphereDecoder : Decoder Atmosphere
atmosphereDecoder =
    decode Atmosphere
        |> required "humidity" string
        |> required "pressure" string
        |> required "rising" string
        |> required "visibility" string


type alias Image =
    { height : String
    , link : String
    , title : String
    , url : String
    , width : String
    }


imageDecoder : Decoder Image
imageDecoder =
    decode Image
        |> required "height" string
        |> required "link" string
        |> required "title" string
        |> required "url" string
        |> required "width" string


type alias Item =
    { condition : Condition
    , description : String
    , forecast : List ForecastEntry
    , guid : Guid
    , lat : String
    , link : String
    , long : String
    , pubDate : String
    , title : String
    }


itemDecoder : Decoder Item
itemDecoder =
    decode Item
        |> required "condition" conditionDecoder
        |> required "description" string
        |> required "forecast" (list forecastEntryDecoder)
        |> required "guid" guidDecoder
        |> required "lat" string
        |> required "link" string
        |> required "long" string
        |> required "pubDate" string
        |> required "title" string


type alias Condition =
    { code : String
    , date : String
    , temp : String
    , text : String
    }


conditionDecoder : Decoder Condition
conditionDecoder =
    decode Condition
        |> required "code" string
        |> required "date" string
        |> required "temp" string
        |> required "text" string


type alias ForecastEntry =
    { code : String
    , date : String
    , day : String
    , high : String
    , low : String
    , text : String
    }


forecastEntryDecoder : Decoder ForecastEntry
forecastEntryDecoder =
    decode ForecastEntry
        |> required "code" string
        |> required "date" string
        |> required "day" string
        |> required "high" string
        |> required "low" string
        |> required "text" string


type alias Guid =
    { isPermaLink : String
    }


guidDecoder : Decoder Guid
guidDecoder =
    decode Guid
        |> required "isPermaLink" string


type alias Location =
    { city : String
    , country : String
    , region : String
    }


locationDecoder : Decoder Location
locationDecoder =
    decode Location
        |> required "city" string
        |> required "country" string
        |> required "region" string


type alias Units =
    { distance : String
    , pressure : String
    , speed : String
    , temperature : String
    }


unitsDecoder : Decoder Units
unitsDecoder =
    decode Units
        |> required "distance" string
        |> required "pressure" string
        |> required "speed" string
        |> required "temperature" string


type alias Wind =
    { chill : String
    , direction : String
    , speed : String
    }


windDecoder : Decoder Wind
windDecoder =
    decode Wind
        |> required "chill" string
        |> required "direction" string
        |> required "speed" string
