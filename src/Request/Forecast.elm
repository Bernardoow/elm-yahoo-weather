module Request.Forecast exposing (getForecast)

import Data.Forecast exposing (Forecast, forecastDecoder)
import Http
import HttpBuilder


getForecast : String -> Http.Request Forecast
getForecast place =
    let
        url =
            "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22" ++ place ++ "%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
    in
        HttpBuilder.get url
            |> HttpBuilder.withExpect (Http.expectJson forecastDecoder)
            |> HttpBuilder.toRequest
